Rails.application.routes.draw do
  resources :posts, except: :new
  resources :likings, only: :destroy
  get "/like_post/:user_id/:post_id", to: "likings#like", as: "like_post"
  resources :friendships, only: :destroy
  get "/accept_request/:id", to: "friendships#accept", as: "accept_request"
  devise_for :users
  root "posts#index"
end
