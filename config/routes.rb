Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users
  root to: 'store/products#index'

  namespace :users, path: '' do
    resource :profile, only: %w(show edit update) do
      resources :orders, only: 'show'
    end
  end

  namespace :store do
    root to: "products#index"
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

  resources :pages, path: '/', only: 'show'
end
