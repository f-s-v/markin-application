ActiveAdmin.register Order do

  menu parent: "Store"

  actions :all, :except => [:destroy, :new]
  filter :public_id, label: 'ID'
  # filter :user
  # filter :country
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

    def permitted_params
      params.permit!
    end
  end

  member_action :delivered, method: :post do
    resource.send_message :delivered
    redirect_to [:admin, resource], notice: t('.notice')
  end
  
  action_item only: :show do
    link_to t('.delivered'), delivered_admin_order_path, method: :post
  end
  
  member_action :sent, method: :post do
    resource.send_message :sent
    redirect_to [:admin, resource], notice: t('.notice')
  end
  
  action_item only: :show do
    link_to t('.sent'), sent_admin_order_path, method: :post
  end
  
  member_action :refund, method: :post do
    payment = resource.payments.find(params[:payment])
    payment.refund
    redirect_to [:admin, resource]
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
        link_to [:admin, item.product] do
          item.product.name.value
        end
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
      column :refund do |payment|
        if payment.state == 'paid'
          link_to t('.refund'), refund_admin_order_path(payment: payment.id), method: :post, data: {confirm: 'Confirm.'}
        end
      end
    end

    h3 "Messages"
    table_for order.messages do
      column :text
      column :created_at
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
      row :country do
        order.shipping_info.country.name
      end
      row :shipping_address_line1 do
        order.shipping_info.shipping_address_line1
      end
      row :shipping_address_line2 do
        order.shipping_info.shipping_address_line2
      end
      row :shipping_city do
        order.shipping_info.shipping_city
      end
      row :shipping_state do
        order.shipping_info.shipping_state
      end
      row :shipping_zip do
        order.shipping_info.shipping_zip
      end
      row :phone_number do
        order.shipping_info.phone_number
      end
    end
  end

  form do |f|
    f.inputs for: :shipping_info do |sif|
      sif.input :country
      sif.input :shipping_address_line1
      sif.input :shipping_address_line2
      sif.input :shipping_city
      sif.input :shipping_state
      sif.input :shipping_zip
      sif.input :phone_number
    end
    f.actions :country_id, :shipping_address_line1,
      :shipping_address_line2, :shipping_city,
      :shipping_state, :shipping_zip, :phone_number
  end

  # permit_params 
end



