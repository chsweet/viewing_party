class PartiesController < ApplicationController
  def new
    json_movie = MovieDbService.new.movie_details(params[:movie_id])
    @movie = Movie.new(json_movie)
    @party = Party.new
  end

  def create
    json_movie = MovieDbService.new.movie_details(params[:party][:movie_id])
    @movie = Movie.new(json_movie)
    party = Party.create!(party_params)

    unless current_user.user_friends.empty?
      params[:party][:invited].each do |key, value|
         if value == '1'
           Attendee.create!(party_id: party.id, user_id: key.to_i)
         end
      end
    end

    redirect_to dashboard_path
  end

private
   def party_params
     params.require(:party).permit(:movie_id, :movie, :user_id, :duration, :date_time)
   end
end
