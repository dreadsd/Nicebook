Rails.application.routes.draw do
  resources :posts, except: :new
  resources :likings, only: [:create, :destroy]
  devise_for :users
  root "posts#index"
end
