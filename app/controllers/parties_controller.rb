class PartiesController < ApplicationController
  def new
    @movie = MovieDbFacade.movie_details(params[:movie_id])
    @party = Party.new
  end

  def create
    @movie = MovieDbFacade.movie_details(params[:party][:movie_id])
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
