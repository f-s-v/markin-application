Rails.application.routes.draw do
  devise_for :users
  root to: 'store/products#index'

  namespace :store do
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

# "
# get /store/products/<public_id>
#   Показывает продукт
#   Показывает форму на добавление продукта в корзинуs

# get /store/order
#   Показывает текущий заказ
# get /store/order/edit
#   Фотма для редактирования текужего заказа
# patch /store/order
#   Обновляет текущий заказ
# delete /store/order
#   Отменяет текущий заказ
# post /store/order/items
#   -> product_id
#   -> size
#   -> quantity
#   Добавляет продукт к заказу

# get /store/order/payments/new
# get /store/order/payments/pay?token=<token>
# get /store/order/payments/cancel?token=<token>

# get /profile/orders
# "