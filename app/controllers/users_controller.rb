class UsersController < ApplicationController
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
    @friends = Follow.user_friends(current_user)
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
