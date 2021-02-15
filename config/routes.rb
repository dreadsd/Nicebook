Rails.application.routes.draw do
  resources :posts, except: :new
  resources :likings, only: [:create, :destroy]
  resources :friendships, only: :destroy
  get "/accept_request/:id", to: "friendships#accept", as: "accept_request"
  devise_for :users
  root "posts#index"
end
