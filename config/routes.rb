Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users, path: 'client-care'
  root to: 'store/products#index'

  namespace :users, path: 'client-care' do
    resource :profile, only: %w(show edit update), path: '' do
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
