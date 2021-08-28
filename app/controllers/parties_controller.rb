class PartiesController < ApplicationController
  def new
    json_movie = MovieDbService.new.movie_details(params[:movie_id])
    @movie = Movie.new(json_movie)
    @party = Party.new
  end

  def create
    json_movie = MovieDbService.new.movie_details(params[:party][:movie_id])
    @movie = Movie.new(json_movie)
    time = DateTime.parse(params[:party]['date_time(1i)']+params[:party]['date_time(2i)']+params[:party]['date_time(3i)']+'T'+params[:party]['date_time(4i)']+params[:party]['date_time(5i)'])
    party = Party.create!(movie_id: @movie.id, movie: @movie.title, user_id: current_user.id, duration: params[:party][:duration], date_time: time)

    params[:party][:invited].each do |key, value|
       if value == '1'
         require "pry";binding.pry
         Attendee.new(party_id: party.id, user_id: key)
       end
    end

    redirect_to dashboard_path
  end
end
