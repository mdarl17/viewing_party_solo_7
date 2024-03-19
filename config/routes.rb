Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")


  root "welcome#index"
  get '/register', to: 'users#new', as: 'register_user'

  get '/users/:id/discover', to: 'users#discover', as: 'discover_movies'

  get '/users/:id/search_results', to: 'users#search_results', as: 'search_results'

  resources :users, only: [:show, :create] do
  end
end