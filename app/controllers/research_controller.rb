class ResearchController < ApplicationController
  before_filter :authenticate_user!
  def index

  end

  def create
    @ticker = params[:ticker].upcase
    @data = YahooFinance::get_graph_data(@ticker)
    @data_candlestick = YahooFinance::get_candlestick_data(@ticker)
  end

end
