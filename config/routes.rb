Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")


  root "welcome#index"
  get '/register', to: 'users#new', as: 'register_user'

  get '/users/:id/discover', to: 'users#search', as: 'search_movies'
  get '/users/:id/movies', to: 'movies#index', as: 'movies_results'

  resources :users, only: [:show, :create] do
    resources :movies, only: [:show] do 
      resources :viewing_party, only: [:new, :create]
    end
  end
end