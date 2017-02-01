Rails.application.routes.draw do

  devise_for :users

  root 'pages#index'
  get 'about', to: 'pages#about'
  get 'shop', to: 'pages#shop'
  get 'how-it-works', to: 'pages#how_it_works', as: 'how'

  # get 'discover/:destination_name/:id', to: 'destinations#discovery', as: 'destination_discovery'

  # Interactive Page Routing
  # ["music", "foods", "art", "geography", "culture", "political", "points_of_interest"].each do |type|
  #   get "immersive/:destination_name/:id/#{type}", to: "destinations##{type}_immersive", as: "#{type}_immersive"
  # end

  get 'cart/:id', to: 'cart#show', as: 'cart'
  get 'load_cart/:id', to: 'cart#load_cart', as: 'load_cart' #ajax call to show cart items in hover

  get 'checkout', to: 'cart#checkout'
  get 'account', to: 'cart#account'
  get 'admin', to: 'admin#dashboard'
  get 'admin/pull_list', to: 'admin#pull_list'
  get 'admin/todays_orders', to: 'admin#todays_orders', as: 'daily_orders'
  get 'admin/todays_shipped_orders', to: 'admin#todays_shipped_orders', as: 'orders_shipped'


  # resources :destinations, only: [:index]
  resources :meals, only: [:index, :show]
  resources :order do
    post 'add_item'
    delete 'subtract_item'
    post 'shipped'
  end
  resources :charges
end
