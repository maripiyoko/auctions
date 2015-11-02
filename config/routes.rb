Rails.application.routes.draw do
  get 'auctions/index'

  get 'auctions/show'

  devise_for :users
  root 'auctions#index'

  resources :auctions, only: [ :show, :index ] do
    resources :bids
    resources :comments
  end

  namespace :my do
    resources :products
    resources :auctions
  end
end
