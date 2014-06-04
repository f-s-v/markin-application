ActiveAdmin.register Order do

  menu parent: "Store"

  actions :all, :except => [:destroy, :new]
  filter :public_id, label: 'ID'
  filter :user
  filter :country
  filter :created_at
  filter :shipping_address_line1
  filter :shipping_address_line2
  filter :shipping_city
  filter :shipping_state
  filter :shipping_zip
  filter :phone_number


  controller do
    defaults finder: :find_by_public_id!

    def scoped_collection
      Order.completed.includes(:country, :user)
    end
  end

  index do
    selectable_column
    column 'ID' do |order|
      link_to order.public_id, [:admin, order]
    end
    column :user
    column :total do |order|
      number_to_currency order.total
    end
    column :country
    column :shipping_city
    column :created_at
    actions
  end

  show title: :public_id do

    h3 "Items"
    table_for order.items do
      column :product do |item|
        link_to item.product.name, [:admin, item.product]
      end
      column :amount
      column :size
      column :price do |item|
        number_to_currency item.price
      end
    end

    h3 "Payments"
    table_for order.payments do
      column :created_at
      column :state
      column :payment_token
      column :payer_token
      column :payer_ip
    end
  end

  sidebar "details", only: :show do
    attributes_table_for order do
      row "ID" do
        order.public_id
      end
      row :user
      row :total do
        number_to_currency order.total
      end
      row :created_at
      row :country
      row :shipping_address_line1
      row :shipping_address_line2
      row :shipping_city
      row :shipping_state
      row :shipping_zip
      row :phone_number
    end
  end

  form do |f|
    f.inputs do
      f.input :country
      f.input :shipping_address_line1
      f.input :shipping_address_line2
      f.input :shipping_city
      f.input :shipping_state
      f.input :shipping_zip
      f.input :phone_number
    end
    f.actions :country, :shipping_address_line1,
      :shipping_address_line2, :shipping_city,
      :shipping_state, :shipping_zip, :phone_number
  end

  permit_params
end



