Rails.application.routes.draw do
  resources :ads
  resources :websites
  root to: 'visitors#index'
  devise_for :users
  resources :users

  get "/ads/:id/forward" => "ads#forward", as: :forward
  get "/websites/:id/display" => "websites#display", as: :display

  get "/house" => "websites#house", as: :house


end
