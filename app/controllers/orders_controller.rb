class OrdersController < ApplicationController

  before_filter :authenticate_user!
  before_filter :check_league_is_open, only: [:new, :create]

  # Very much a work in progress
  def create

    respond_to do |format|
      format.js
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
