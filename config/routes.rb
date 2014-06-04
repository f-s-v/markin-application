Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users
  root to: 'store/products#index'

  namespace :users, path: '' do
    resource :profile, only: %w(show edit update) do
      resources :orders, only: 'show'
    end
  end

  namespace :store, path: '' do
    resources :products
    resource :order do
      resources :items, controller: 'order/items'
      resources :payments do
        collection do
          get :pay
          get :cancel
        end
      end
    end
  end

  namespace :mgmt do
    root to: 'users#index'
    resources :users
    resources :products
    resources :batches
    resources :characteristics
  end
end
