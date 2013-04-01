class LeaguesController < ApplicationController
  before_filter :authenticate_user!

  # implemented and partially tested
  def create
      @league = League.new(params[:league])
      @league.creator_id = current_user.id
      # attempt to save league so as to get its id
      @league.save
      # Need to reload to get the league id back after the save
      @league.reload
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

  # implemented and partially tested
  def index
      @leags = League.all
      @filtered = false
      if params[:filter] != nil
        @leags = League.where("name LIKE ?", "%"+params[:filter]+"%")
        @filtered = true
      end
      @leagues = League.where(:private => false).paginate(:page => params[:page])
  end

  # not implemented
  def destroy
  end

  # implemented and partially tested
  def show
     @league = League.find(params[:id])
     @title = @league.name   

     # List of portfolios to render
     @portfolios = Portfolio.where(:league_id=>@league.id).paginate(:page=>params[:page], :per_page=>10)
     # Create a local portfolio if user isn't in league and decides to join
     @portfolio = Portfolio.where("user_id = ? AND league_id = ?",current_user.id, @league.id).first
     @portfolio = @league.portfolios.build if @portfolio.nil?
  end

  # not implemented
  def edit
  end
  def update
  end

  # implemented, shouldn't need to be tested...
  def new
    @league = League.new
  end

  private

  # implemented and tested
  def create_manager_portfolio(league)
    @portfolio = Portfolio.new(:capital => league.capital, :user_id => current_user.id,
                               :margin => league.capital, :manager => true,
                                :league_id => league.id)
  end
end
