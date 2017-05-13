Rails.application.routes.draw do
  resources :users, only: %i[new index create show]
  resources :attractions, only: %i[index show new create update edit]

  root 'users#index'

  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  post '/logout' => 'sessions#destroy'
  post '/attractions/:id/ride' => 'attractions#ride', as: :ride
end