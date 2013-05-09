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
  def edit
     @user = User.find(params[:id])
     @title = "Your settings" 
  end
  def update
   @user = User.find(params[:id])
   if @user.update_attributes(params[:user])
     redirect_to :back
   end
  end

end
