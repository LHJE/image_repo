Rails.application.routes.draw do
  root to: 'welcome#index'

  get '/registration', to: 'users#new', as: :registration
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#login'
  get '/logout', to: 'sessions#logout'

  get '/search', to: 'search#index'

  resources :users, only: [:create]

  resources :posts
end
