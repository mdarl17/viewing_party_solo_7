class MoviesController < ApplicationController
  def index
    @user = User.find(params[:id])
    facade = MovieFacade.new
    
    if params[:commit] == "Find Top Rated Movies"
      @movies = facade.top_movies
      render :index
      return
    elsif params[:keywords]
      @movies = facade.keywords_search(params[:keywords])
      render :index
      return
    end
    render "users/search"
  end

  def show 
    facade = MovieFacade.new
    @user = User.find(params[:id])
    movie_data = facade.aggregate_movie_data(params[:movie_id])
    @movie = movie_data[:movie]
    @cast = movie_data[:cast]
    @reviews = movie_data[:reviews]
  end
end