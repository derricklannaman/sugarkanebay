Rails.application.routes.draw do

  devise_for :users

  root 'pages#index'
  get 'about', to: 'pages#about'
  get 'shop', to: 'pages#shop'
  get 'how-it-works', to: 'pages#how_it_works', as: 'how'

  get 'discover/:destination_name/:id', to: 'destinations#discovery', as: 'destination_discovery'

  # Interactive Page Routing
  ["music", "foods", "art", "geography", "culture", "political", "points_of_interest"].each do |location|
    get "discover/:destination_name/:id/#{location}", to: "destinations##{location}", as: "destination_#{location}"
  end


  get 'cart/:id', to: 'cart#show', as: 'cart'
  get 'checkout', to: 'cart#checkout'
  get 'account', to: 'cart#account'

  resources :destinations, only: [:index]
  resources :meals, only: [:index, :show]
  resources :order do
    post 'add_item'
    delete 'subtract_item'
  end
  resources :charges
end
