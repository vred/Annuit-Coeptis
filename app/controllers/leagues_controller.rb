class LeaguesController < ApplicationController
  before_filter :authenticate_user!

  def create
      @league = League.new(params[:league])
      @league.creator_id = current_user.id
      # attempt to save league so as to get its id
      @league.save
      # Create the signed in user's portfolio as a league manager
      @portfolio = create_manager_portfolio(@league)
      if @portfolio.save
        # Flash a success message
        flash[:success] = "Created your league!"
        # Send them to the league
        redirect_to @league
      else
        @league.delete
        flash[:fail] = "Sorry, that didn't work!"
        render 'new'
      end
  end

  def index
      @leagues = League.where(:private => false).paginate(:page => params[:page])
  end

  def destroy

  end

  def show
     @league = League.find(params[:id])
     @portfolio = @league.portfolios.build
  end

  def edit

  end

  def update

  end

  def new
    @league = League.new
  end

  private
  def create_manager_portfolio(league)
    @portfolio = Portfolio.new(:capital => league.capital, :user_id => current_user,
                               :margin => league.capital, :manager => true,
                                :league_id => league.id)
  end
end