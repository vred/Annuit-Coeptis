class UsersController < ApplicationController
  # To change this template use File | Settings | File Templates.
  def index
    @users = User.paginate(:page => params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

end