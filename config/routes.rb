Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")


  root "welcome#index"
  get '/register', to: 'users#new', as: 'register_user'

  get '/users/:id/discover', to: 'users#discover', as: 'discover'
  get '/users/:id/movies', to: 'movies#index', as: 'movies_results'

  get "/users/:id/movies/:movie_id", to: "movies#show", as: "movie_details"

  resources :users, only: [:show, :create] do
    resources :viewing_party, only: [:new, :create]
  end
end