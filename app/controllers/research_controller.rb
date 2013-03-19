class ResearchController < ApplicationController
  before_filter :authenticate_user!
  def index
  end

  def create
    @ticker = params[:ticker]
  end

end