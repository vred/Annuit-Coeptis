class UsersController < ApplicationController
  before_filter :authenticate_user!
  # To change this template use File | Settings | File Templates.
  def index
    @users = User.paginate(:page => params[:page])
    @us = User.all
  end

  def show
    @user = User.find(params[:id])
  end

end
