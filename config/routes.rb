Rails.application.routes.draw do
  devise_for :users
  root to: 'dummy#index'
  namespace :mgmt do
    root to: 'users#index'
    resources :users
  end
end
