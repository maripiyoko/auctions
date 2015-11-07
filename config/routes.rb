Rails.application.routes.draw do
  devise_for :users
  root 'auctions#index'

  resources :auctions, only: [ :show, :index ] do
    resource :bid, only: [ :new, :create, :destroy ]
    resources :comments
  end

  namespace :my do
    resources :products
    resources :auctions
  end
end
