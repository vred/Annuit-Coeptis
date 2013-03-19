class PortfoliosController < ApplicationController
  before_filter :authenticate_user!

  def create
    # Need separate join mechanisms for
    # invited to private league, joining
    # public league, and maybe even creating League Manager?
    # For now only let public users join public leagues
    # through this mechanism
    def create
      # Add logic to check whether the league is full first
      unless Portfolio.where(:user_id => current_user, :league_id => params[:league_id])
        @league = League.find(params[:league_id])
        @portfolio = @league.portfolios.build(:capital => @league.capital,
                                              :margin => @league.margin, :role => 0)
        if @portfolio.save
          # flash[:success] = "Welcome to the league!"
          redirect_to league_portfolio_url(@portfolio)
        else
          # flash[:fail] = "Sorry, you were unable to join this league."
          redirect_to leagues_url(params[:league_id])
        end
      end
      # flash[:fail] = "You're already in the league!"
      redirect_to leagues_url
   end
end

  def show
    @portfolio = Portfolio.find(params[:id])
  end

  def destroy
  end
end