Rails.application.routes.draw do
  devise_for :users
  root 'auctions#index'

  resources :auctions, only: [ :show, :index ] do
    resources :bids
    resources :comments
  end

  namespace :my do
    resources :goods
    resources :auctions
  end
end
