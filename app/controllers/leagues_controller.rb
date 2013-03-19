class LeaguesController < ApplicationController
  before_filter :authenticate_user!

  def create
      @league = League.new(params[:league])
      @league.user_id = current_user.id
      # Create the signed in user's portfolio as a league manager
      create_manager_portfolio(params[:league])
      if @league.save and @portfolio.save
        # Flash a success message
        flash[:success] = "Created your league!"
        # Send them to the league
        redirect_to @league
      else
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
  def create_manager_portfolio(params)
    @portfolio = Portfolio.new(:capital => params[:capital],
                               :margin => params[:margin], :role => 1)
    @portfolio.user_id = current_user.id
  end
end