class OrdersController < ApplicationController

  before_filter :authenticate_user!
  before_filter :check_league_is_open, only: [:new, :create]

  # Very much a work in progress
  def create

    logger.info("I'm in create!")

    if(params[:order_type] == "MarketOrder")
      new_order = MarketOrder.new
    elsif(params[:order_type] == "StopOrder")
      new_order = StopOrder.new

      new_order.threshold_price = params[:threshold_price];
      new_order.duration_valid = params[:duration_valid];
    elsif(params[:order_type] == "LimitOrder")
      new_order = LimitOrder.new

      new_order.threshold_price = params[:threshold_price];
      new_order.duration_valid = params[:duration_valid];
    else
      flash[:fail] = "Invalid order type."
      redirect_to :back
      return
    end

    new_order.ticker = params[:ticker];
    new_order.quantity = params[:quantity];
    new_order.type = params[:order_type];
    new_order.time_placed = DateTime.now;
    new_order.trade_type = params[:trade_type];
    new_order.league_id = params[:league_id];
    new_order.portfolio_id = params[:portfolio_id];

    if(new_order.trade_type == "buy")
      new_order.price_executed = YahooFinance::get_standard_quotes(new_order.ticker)[new_order.ticker].ask;
    elsif(new_order.trade_type == "sell")
      new_order.price_executed = YahooFinance::get_standard_quotes(new_order.ticker)[new_order.ticker].bid;
    end

    if(Portfolio.find(new_order.portfolio_id).capital_cents < new_order.quantity*new_order.price_executed_cents)
      flash[:fail] = "Not enough funds."
      new_order.delete
      redirect_to :back;
      return
    else
      current_portfolio = Portfolio.find(new_order.portfolio_id)
      current_portfolio.capital_cents -= new_order.quantity*new_order.price_executed_cents
      current_portfolio.save()
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
  
  protected
  
  def check_league_is_open
    @league = League.find(params[:league_id])
    if @league.end_date < Date.today or @league.start_date > Date.today
      flash[:fail] = "This league is not currently open!"
      redirect_to :back
    end
  end
  
end
