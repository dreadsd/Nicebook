Rails.application.routes.draw do
  resources :comments
  resources :posts, except: :new

  resources :likings, only: :destroy
  get "/like_post/:id", to: "likings#like", as: "like_post"

  resources :friendships, only: :destroy
  get "/send_request/:id", to: "friendships#send_request", as: "send_request"
  get "/accept_request/:id", to: "friendships#accept", as: "accept_request"
  get "/unfriend/:id", to: "friendships#unfriend", as: "unfriend"

  devise_for :users
  root "posts#index"
end
