class UsersController < ApplicationController
  skip_before_action :require_authentication, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    new_user = User.create(user_params)
    session[:user_id] = new_user.id
    redirect_to dashboard_path
  end

  def show
    require "pry";binding.pry
    @follow = Follow.new
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
