Rails.application.routes.draw do
  devise_for :users
  root to: 'dummy#index'

  namespace :store do
    resources :products
    resource :cart do
      get :checkout
      get :cancel_checkout
      resources :items, controller: 'cart/items' do
        member do
          post :increase
          post :decrease
        end
      end
      resources :payments
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
