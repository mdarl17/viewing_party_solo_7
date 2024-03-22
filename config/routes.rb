Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")


  root "welcome#index"
  get '/register', to: 'users#new', as: 'register_user'

  get '/users/:id/discover', to: 'users#discover', as: 'discover'
  get '/users/:id/movies', to: 'movies#index', as: 'movies_results'

  get "/users/:id/movies/:movie_id", to: "movies#show", as: "movie_details"
  get "/users/:user_id/movies/:movie_id/viewing_party/new", to: "viewing_parties#new", as: "new_viewing_party"
  post "/users/:user_id/movies/:movie_id/viewing_party", to: "viewing_parties#create", as: "create_viewing_party"

  get "/users/:user_id", to: "users#show", as: "user_dashboard"

  resources :users, only: [:create] do
  end
end