class UsersController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @users = User.paginate(:page => params[:page])
    @us = User.all
  end

  def show
    @focus = false
    if flash[:focus] == true
      @focus = true
    end
    @user = User.find(params[:id])
  end

end
