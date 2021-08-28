class PartiesController < ApplicationController
  def new
    #require "pry";binding.pry
    json_movie = MovieDbService.new.movie_details(params[:movie_id])
    @movie = Movie.new(json_movie)
  end

  def create
    json_movie = MovieDbService.new.movie_details(params[:movie_id])
    @movie = Movie.new(json_movie)
  end
end
