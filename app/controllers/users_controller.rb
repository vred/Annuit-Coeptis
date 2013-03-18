class UsersController < ApplicationController
  # To change this template use File | Settings | File Templates.
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

end