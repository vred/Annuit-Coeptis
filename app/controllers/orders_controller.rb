class OrdersController < ApplicationController

  before_filter :authenticate_user!
  before_filter :check_league_is_open, only: [:new, :create]

  # Very much a work in progress
  def create
    @league = League.find(params[:league_id])
    @portfolio = Portfolio.find(params[:portfolio_id])
    @order = Order.new(params[:order])
	# change "duration_valid" to "experiation_date" using the datetime emthods
	unless @order.type == "Market"	
		@order.expiration_date = params[:order][:duration_valid].days.from_now
    @order.league_id = @league.id
    @order.portfolio_id = @portfolio.id

    if @order.save
      flash[:success] = "Order placed!"
    else
      flash[:fail] = "Order not successful!"
    end
    redirect_to :back
  end

  def show
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
