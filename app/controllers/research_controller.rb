class ResearchController < ApplicationController
  before_filter :authenticate_user!
  def index

  end

  def create
    @ticker = params[:ticker].upcase
    @data_simple = YahooFinance::get_graph_data(@ticker)
    @data_candlestick = YahooFinance::get_candlestick_data(@ticker)
    @data_now = YahooFinance::get_standard_quotes(@ticker)[@ticker]
  end

end
