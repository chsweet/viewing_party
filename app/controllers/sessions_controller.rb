class SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:email].downcase)
    if user.nil?
      flash[:error] = 'Account does not exist. Have you tried registering?'
      redirect_to root_path
    elsif user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'The username or password you entered is incorrect'
      redirect_to root_path
    end
  end
end
