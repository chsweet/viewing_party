class MoviesController < ApplicationController
  def discover
    @user = current_user
  end

  def index

  end
end
