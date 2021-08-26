class MoviesController < ApplicationController
  def discover
  end

  def index
    json = MovieDbService.new.top_40
    @top_movies = json.map do |movie|
      Movie.new(movie)
    end
  end
end
