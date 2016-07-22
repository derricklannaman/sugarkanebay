Rails.application.routes.draw do
  devise_for :users

  root 'pages#index'
  get 'about', to: 'pages#about'
  get 'shop', to: 'pages#shop'
  get 'how-it-works', to: 'pages#how_it_works', as: 'how'
end
