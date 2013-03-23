class OrdersController < ApplicationController

  before_filter :authenticate_user!
  before_filter :check_league_is_open, only: [:new, :create]

  def create
    @order = Order.new(params[:order])
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