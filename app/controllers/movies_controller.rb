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
      @movies
      render :index
      return
    end
    render "users/search"
  end

  def show 
    facade = MovieFacade.new
    @user = User.find(params[:id])
    @movie = facade.find_movie_with_id(params[:movie_id])[0]
  end
end