class ApplicationController < ActionController::Base
  before_action :require_authentication
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def require_authentication
    if current_user.nil?
      flash[:alert] = "Uh Oh, Can't go there! Try logging in or registering as a new user."
      redirect_to root_path
    end
  end
end
