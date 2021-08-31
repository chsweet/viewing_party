class MoviesController < ApplicationController
  def discover
  end

  def index
    if params[:search].nil?
      @movies = MovieDbFacade.create_movie_instances(MovieDbFacade.top_40)
    else
      @movies = MovieDbFacade.create_movie_instances(MovieDbFacade.search(params[:search].downcase))
    end
  end

  def show
    @movie = MovieDbFacade.movie_details(params[:id])
    @actors = MovieDbFacade.movie_actors(params[:id])
    @reviews = MovieDbFacade.movie_reviews(params[:id])
  end
end
