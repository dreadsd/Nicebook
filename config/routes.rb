Rails.application.routes.draw do
  resources :posts
  resources :likings, only: [:create, :destroy]
  devise_for :users
  root "posts#index"
end
