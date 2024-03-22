class UsersController < ApplicationController

  def new
  end

  def create
    user = User.new(user_params)
  end

  def discover
    @user = User.find(params[:id])
  end

  def show 
    @user = User.find(params[:user_id])
  end

private

  def user_params
    params.permit(:name, :email)
  end
end