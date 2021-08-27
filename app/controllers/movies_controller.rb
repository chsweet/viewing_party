class MoviesController < ApplicationController
  def discover
  end

  def index
    if params[:search].nil?
      json = MovieDbService.new.top_40
    else
      json = MovieDbService.new.search(params[:search].downcase)
    end
    @movies = json.map do |movie|
      Movie.new(movie)
    end
  end

  def show
    json = MovieDbService.new.movie_details(params[:id])
    @movie = Movie.new(json)
  end
end
