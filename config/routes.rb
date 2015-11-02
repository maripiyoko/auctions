Rails.application.routes.draw do
  namespace :my do
  get 'auctions/index'
  end

  namespace :my do
  get 'auctions/new'
  end

  namespace :my do
  get 'auctions/edit'
  end

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
