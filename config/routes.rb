Rails.application.routes.draw do
  devise_for :users
  root 'auctions#index'

  resources :auctions, only: [ :show, :index ] do
    resource :bid, only: [ :new, :create, :destroy ]
  end

  namespace :my do
    resources :products
    resources :auctions
    resources :comments
  end
end
