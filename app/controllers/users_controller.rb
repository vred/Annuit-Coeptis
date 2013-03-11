class UsersController < ApplicationController
  # To change this template use File | Settings | File Templates.
  def index
    @user = User.find(params[:id])
  end

end