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
    port = Portfolio.find(params[:id])
    redir = port.league_id
    if port.present?
      port.delete
    end
    redirect_to league_url(redir)
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
