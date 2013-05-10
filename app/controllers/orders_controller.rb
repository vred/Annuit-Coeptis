class OrdersController < ApplicationController

  before_filter :check_league_is_open, only: [:new, :create]

  # Very much a work in progress
  def create

    logger.info("I'm in create!")

    logger.info(params[:order_type]);

    if(params[:order_type] == "MarketOrder")
      new_order = MarketOrder.new
      new_order.time_filled = DateTime.now;
      new_order.trade_type = params[:trade_type];
      new_order.ticker = params[:ticker];

      if(new_order.trade_type == "buy")
        new_order.price_executed = YahooFinance::get_standard_quotes(new_order.ticker)[new_order.ticker].ask;
      elsif(new_order.trade_type == "sell")
        new_order.price_executed = YahooFinance::get_standard_quotes(new_order.ticker)[new_order.ticker].bid;
      end
    elsif(params[:order_type] == "StopOrder")
      new_order = StopOrder.new

      new_order.trade_type = params[:trade_type];
      new_order.ticker = params[:ticker];
      new_order.threshold_price = params[:threshold_price];
      new_order.duration_valid = params[:valid_duration];
      new_order.valid_order = true;
    elsif(params[:order_type] == "LimitOrder")
      new_order = LimitOrder.new

      new_order.trade_type = params[:trade_type];
      new_order.ticker = params[:ticker];
      new_order.threshold_price = params[:threshold_price];
      new_order.duration_valid = params[:valid_duration];
      new_order.valid_order = true;
    else
      flash[:fail] = "Invalid order type."
      redirect_to :back
      return
    end

    new_order.quantity = params[:quantity];
    new_order.type = params[:order_type];
    new_order.time_placed = DateTime.now;
    new_order.league_id = params[:league_id];
    new_order.portfolio_id = params[:portfolio_id];

    if(new_order.type == "MarketOrder")
      if(Portfolio.find(new_order.portfolio_id).capital_cents < new_order.quantity*new_order.price_executed_cents)
        flash[:fail] = "Not enough funds."
        new_order.delete
        redirect_to :back;
        return
      else
        current_portfolio = Portfolio.find(new_order.portfolio_id)

        if(new_order.trade_type == "buy")
          current_portfolio.capital_cents -= new_order.quantity*new_order.price_executed_cents
        elsif(new_order.trade_type == "sell")
          current_portfolio.capital_cents += new_order.quantity*new_order.price_executed_cents
        end
        current_portfolio.save()

        day_performance = Performance.where("date = ? and portfolio_id = ?",Date.today, current_portfolio.id).first;

        if day_performance.nil?
          day_performance = Performance.new();
          day_performance.portfolio_id = current_portfolio.id;
          day_performance.league_id = new_order.league.id;
          day_performance.date = Date.today;
        end

        logger.info(day_performance);

        day_performance.closing_capital_cents = current_portfolio.capital_cents;

        day_performance.save();
      end

    end

    new_order.save();

    flash[:success] = "You've successfully placed an order."
    redirect_to(league_portfolio_url(new_order.league_id, new_order.portfolio_id))
  end

  def show
    @order = Order.find(params[:id]);
  end
  
  def new
    @order = Order.new
  end

  def process_async_orders

    outstanding_orders = Order.where("type != 'MarketOrder' and valid_order = 't'");

    for outstanding_order in outstanding_orders

      datetime_expired = outstanding_order.time_placed+(outstanding_order.duration_valid*60*60*24);

      logger.info(outstanding_order);

      if datetime_expired < DateTime.now
        outstanding_order.valid_order = false;
        outstanding_order.save();
        next;
      end

      logger.info(outstanding_order);

      current_stock_price_cents_asking = YahooFinance::get_standard_quotes(outstanding_order.ticker)[outstanding_order.ticker].ask*100;
      current_stock_price_cents_bidding = YahooFinance::get_standard_quotes(outstanding_order.ticker)[outstanding_order.ticker].bid*100;
      
      logger.info(outstanding_order.threshold_price_cents);


      if ((outstanding_order.trade_type == "sell" && (outstanding_order.threshold_price_cents <= current_stock_price_cents_bidding)) || (outstanding_order.trade_type == "buy" && (outstanding_order.threshold_price_cents >= current_stock_price_cents_asking)))

        outstanding_order.valid_order = false;

        if(Portfolio.find(outstanding_order.portfolio_id).capital_cents < outstanding_order.quantity*outstanding_order.price_executed_cents)
          logger.info ("Not enough funds.")
          next;
        else
          outstanding_order.time_filled = DateTime.now;
          current_portfolio = Portfolio.find(outstanding_order.portfolio_id)

          if(outstanding_order.trade_type == "buy")
            outstanding_order.price_executed = current_stock_price_cents_asking/100;
            current_portfolio.capital_cents -= outstanding_order.quantity*outstanding_order.price_executed_cents
          elsif(outstanding_order.trade_type == "sell")
            outstanding_order.price_executed = current_stock_price_cents_bidding/100;
            current_portfolio.capital_cents += outstanding_order.quantity*outstanding_order.price_executed_cents
          end
          current_portfolio.save()

          day_performance = Performance.where("date = ? and portfolio_id = ?",Date.today, current_portfolio.id).first;

          if day_performance.nil?
            day_performance = Performance.new();
            day_performance.portfolio_id = current_portfolio.id;
            day_performance.league_id = outstanding_order.league.id;
            day_performance.date = Date.today;
          end

          logger.info(day_performance);

          day_performance.closing_capital_cents = current_portfolio.capital_cents;

          day_performance.save();

          outstanding_order.save();
        end


      end

    end

    exit;
  end
  
  protected
  
  def check_league_is_open
    @league = League.find(params[:league_id])
    if @league.end_date < Date.today or @league.start_date > Date.today
      flash[:fail] = "This league is not currently open!"
      redirect_to :back
    end
  end
  
end
