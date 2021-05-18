Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "welcome#index"

  get '/register', to:'users#new'
  post '/register', to: 'users#create'
  get '/discover', to: 'discover#index'
  post '/', to: 'sessions#create'

  resources :movies, only: [:index, :show]
  resources :users, only: [:new, :create]
  resources :dashboard, only: [:index, :create]


  resources :viewing_party, :controller=>"parties"
end
