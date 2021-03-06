Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  root to: 'pages#search'

  resources :places do
    resources :events
  end

  get '/search', to: 'pages#search'
  resources :events
  resources :bucketlists, only: [:new, :create, :show]
  resources :list_events, only: [:new, :create, :destroy]
  resources :list_places, only: [:new, :create, :destroy]
  # get '/show', to: 'places#show', to: 'events#show'

end

