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
        redirect_to league_portfolio_url(:league_id => params[:league_id], :id => params[:id])
      else
        flash[:fail] = "Sorry, you were unable to join this league."
        redirect_to leagues_url(params[:league_id])
      end
    end
    flash[:fail] = "You're already in the league!"
    redirect_to :back
  end

  # Implemented but not tested
  def show
    @portfolio = Portfolio.find(params[:id])
  end

  # Currently not implemented
  def destroy
  end

  protected

  def check_league_not_full
    @league = League.find(params[:league_id])
    if @league.member_limit < @league.portfolios_count
       flash[:fail] = "Sorry, that league is full!"
        redirect_to :back
    end
  end
end