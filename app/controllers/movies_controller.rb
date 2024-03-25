class MoviesController < ApplicationController
  def index
    @user = User.find(params[:id])

    if params[:commit] == ("Find Top Rated Movies")
      @facade = MovieFacade.new(top_movies: true)
    elsif params[:commit] == "Find Movies"
      if params[:keyword_or_movie_id].match(/[0-9]+/)
        @movie = MovieFacade.new(movie_id: params[:keyword_or_movie_id])
      else 
        @facade = MovieFacade.new(keywords: params[:keyword_or_movie_id])
      end
    else
      flash[:message] = "Sorry, we were not able to find any movies with your entry. Please try again."
      render "users/search"
      return
    end
    render :index
  end

  def show
    facade = MovieFacade.new(movie_id: params[:movie_id])
    @user = User.find(params[:id])
    @facade = facade.movies
  end

  private

  def movie_params
    params.permit(:id, :movie_id, :title, :vote, :runtime, :genres, :summary)
  end
end