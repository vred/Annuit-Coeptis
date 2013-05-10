class PortfoliosController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_league_not_full, only: [:create]


  # implemented and partially tested
  def create
    # Add logic to check whether the league is full first
    if Portfolio.where(:user_id => current_user, :league_id => params[:league_id]).first.nil?
      @league = League.find(params[:league_id])
      @portfolio = @league.portfolios.build(:capital => @league.capital, :user_id => current_user.id,
                                            :margin => @league.margin, :manager => false,
                                            :league_id => @league.id)
      if @portfolio.save
        flash[:success] = "Welcome to the league!"

        day_performance = Performance.new();
        day_performance.portfolio_id = @portfolio.id;
        day_performance.league_id = @league.id;
        day_performance.date = Date.today;
        day_performance.closing_capital_cents = @portfolio.capital_cents;
        day_performance.save();

        redirect_to league_url(params[:league_id])
      else
        flash[:fail] = "Sorry, you were unable to join this league."
        redirect_to league_url(params[:league_id])
      end
    else
      flash[:fail] = "You're already in the league!"
      redirect_to :back
    end
  end

  # Implemented but not tested
  def show
    @portfolio = Portfolio.find(params[:id])
  end

  def destroy
    #Get the portfolio we want to remove
    port = Portfolio.find_by_id(params[:id])

    #Find out if it has already been removed (If someone presses it twice)
    if port != nil
      #If not, delete it
      port.delete
    end

    #Go back to the league page
    redirect_to league_url(params[:league_id])
  end

  protected

  def check_league_not_full
    @league = League.find(params[:league_id])
    if @league.member_limit < Portfolio.where("league_id = ?", params[:league_id]).length
       flash[:fail] = "Sorry, that league is full!"
        redirect_to :back
    end
  end
end
