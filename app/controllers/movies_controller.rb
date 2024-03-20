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
end