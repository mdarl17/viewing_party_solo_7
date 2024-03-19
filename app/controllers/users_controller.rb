class UsersController < ApplicationController

   def new
      @user = User.new
   end

   def show
      @user = User.find(params[:id])
   end

   def create
      user = User.new(user_params)
      if user.save
         flash[:success] = 'Successfully Created New User'
         redirect_to user_path(user)
      else
         flash[:error] = "#{error_message(user.errors)}"
         redirect_to register_user_path
      end   
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
      params.require(:user).permit(:name, :email)
  end
end