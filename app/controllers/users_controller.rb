class UsersController < ApplicationController

   def new
   end

   def create
      user = User.new(user_params)
   end

   def discover
      @user = User.find(params[:id])
   end

   def search_results
      @user = User.find(params[:id])
      @movies = Movie.movie_search(:keywords)
   end

private

  def user_params
      params.permit(:name, :email)
  end

end