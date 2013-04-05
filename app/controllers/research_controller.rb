class ResearchController < ApplicationController
  before_filter :authenticate_user!
  def index

  end

  def create
    @ticker = params[:ticker].upcase
    @data_simple = YahooFinance::get_graph_data(@ticker)
    @data_candlestick = YahooFinance::get_candlestick_data(@ticker)
    @data_now = YahooFinance::get_standard_quotes(@ticker)[@ticker]
    @current_user = current_user;

    if @data_now.lastTrade == 0

      flash[:research_fail] = true
      render 'static_pages/permission_denied'
      return

    end

    @league_portfolios = Array.new;

    @current_user.leagues.each do |league|
        portfolio = Portfolio.where(:user_id => @current_user.id, :league_id => league).first;
        @league_portfolios.push({:league => league, :portfolio => portfolio});
    end

  end

end
