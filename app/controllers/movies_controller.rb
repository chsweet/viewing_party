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
    json_movie = MovieDbService.new.movie_details(params[:id])
    @movie = Movie.new(json_movie)
    json_actor = MovieDbService.new.movie_actors(params[:id])
    #move first 10 before .map
    actors = json_actor[:cast].map do |actor|
      if actor[:known_for_department] == 'Acting'
        Actor.new(actor)
      end
    end
    @actors = actors.first(10)
    json_review = MovieDbService.new.movie_reviews(params[:id])
    @reviews = json_review[:results].map do |review|
      Review.new(review)
    end
  end
end
