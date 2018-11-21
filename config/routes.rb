Rails.application.routes.draw do
  root to: 'home#index'
  resources :authorizations, only: [:new]
  resources :users, only: [:new]
end
