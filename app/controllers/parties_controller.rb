class PartiesController < ApplicationController
  def new
    json_movie = MovieDbService.new.movie_details(params[:movie_id])
    @movie = Movie.new(json_movie)
    @party = Party.new
  end

  def create
    json_movie = MovieDbService.new.movie_details(params[:party][:movie_id])
    @movie = Movie.new(json_movie)
    time = Time.new(params[:party]['date_time(1i)'].to_i, params[:party]['date_time(2i)'].to_i, params[:party]['date_time(3i)'].to_i, params[:party]['date_time(4i)'].to_i, params[:party]['date_time(5i)'].to_i)
    party = Party.create!(movie_id: @movie.id, movie: @movie.title, user_id: current_user.id, duration: params[:party][:duration], date_time: time)
    
    unless current_user.user_friends.empty?
      params[:party][:invited].each do |key, value|
         if value == '1'
           Attendee.create!(party_id: party.id, user_id: key.to_i)
         end
      end
    end

    redirect_to dashboard_path
  end
end
