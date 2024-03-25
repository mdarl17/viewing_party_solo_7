class ViewingPartiesController < ApplicationController 
  def new 
    @users = User.all
    @user = User.find(params[:user_id])
    @facade = MovieFacade.new(top_movies: false, keywords: nil, movie_id: params[:movie_id])
  end

  def create
    @user = User.find(params[:user_id])
    @facade = MovieFacade.new(top_movies: false, keywords: false, movie_id: params[:movie_id])
    unless ViewingParty.duration_valid?(params, @facade.movies)
      flash[:alert] = "The party duration can't be shorter than the movie runtime"
      redirect_to new_viewing_party_path(user_id: @user.id, movie_id: @facade.movies.id)
      return
    end

    viewing_party = ViewingParty.new(viewing_party_params)
    
    if viewing_party.save
      viewing_party.user_parties.create(viewing_party_id: viewing_party.id, user_id: params[:user_id], host: true)
      guests = viewing_party.parse_guests(params)
      guests.each do |guest| 
        viewing_party.user_parties.create(user_party_params)
      end
      flash[:message] = "New viewing party created!"
      redirect_to user_dashboard_path(@user.id)
      return
    else
      flash[:alert] = "Sorry, but there was a problem adding the party. Please try again later."
      redirect_to new_viewing_party_path(user_id: @user.id, movie_id: @movie.id)
    end
  end

  private

  def viewing_party_params 
    params.permit(:viewing_party_id, :duration, :date, :start_time, :movie_id)
  end

  def user_party_params 
    params.permit(:viewing_party_id, :user_id, :host)
  end
end