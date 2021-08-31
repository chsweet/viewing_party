class FollowsController < ApplicationController
  def new
  end

  def create
    friend = User.find_by(email: params[:follow][:email])

    if friend.nil?
      flash[:notice] = "I'm sorry your friend cannot be found."
    else
      Follow.create(user_id: current_user.id, friend_id: friend.id)
    end
    redirect_to dashboard_path
  end
end
