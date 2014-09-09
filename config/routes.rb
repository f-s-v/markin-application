Rails.application.routes.draw do
  namespace :api do
    resources :content_holders
  end

  root to: 'store/products#index'
  ActiveAdmin.routes(self)

  scope path: "(:locale)",
    defaults: {locale: I18n.default_locale},
    constraints: {locale: /#{Rails.application.config.i18n_enabled_locales.join('|')}/} do

    devise_for :users, path: 'client-care'

    namespace :users, path: 'client-care' do
      resource :profile, only: %w(show edit update), path: '' do
        resources :orders, only: 'show'
      end
    end

    namespace :store do
      root to: "products#index"
      resources :products, only: [:index, :show]
      resource :order do
        resource :shipping_info, only: [:new, :create, :edit, :update]
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
end
