class UsersController < ApplicationController
  def index
    @users = User.includes(:post).all
    @current_user = current_user
  end

  def show
    @user = User.find(params[:id])
  end
end
