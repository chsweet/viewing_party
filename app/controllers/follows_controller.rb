class FollowsController < ApplicationController
  def new
  end

  def create
    followed = User.find_by(email: params[:follow][:email])
    Follow.create(host_id: current_user.id, followed_id: followed.id)
    redirect_to dashboard_path
  end

  private

end
