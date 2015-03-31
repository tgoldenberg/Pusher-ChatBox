Rails.application.routes.draw do

  resources :posts
  resources :conversations
  resources :messages
  devise_for :users
  root 'static_pages#home'

end
