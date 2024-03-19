class UsersController < ApplicationController

   def new
   end

   def create
      user = User.new(user_params)
   end

   def search
      @user = User.find(params[:id])
      if params[:top_movies]
         # TODO
         # @movies = returns TMDB's top movies hash; http call 
         #   using `top movies` uri
      else
         # TODO
         # facade method; takes advantage of ActiveRecord functions
         #   to implememt `ILIKE` fuzzy title search
         # @movies = facade.new.movie_search(:keywords)
      end
      # TODO
      # redirect_to search results page; check project reqs
   end
private

  def user_params
      params.permit(:name, :email)
  end
end