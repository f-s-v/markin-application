ActiveAdmin.register Order do

  menu parent: "Store"

  actions :all, :except => [:destroy, :new]
  config.filters = false
  
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

    h3 Order.human_attribute_name :items
    table_for order.items do
      column Order::Item.human_attribute_name(:product) do |item|
        link_to [:admin, item.product] do
          item.product.name.value
        end
      end
      column Order::Item.human_attribute_name(:amount), :amount
      column Order::Item.human_attribute_name(:size), :size
      column Order::Item.human_attribute_name(:total) do |item|
        number_to_currency item.total
      end
    end

    h3 Order.human_attribute_name :payments
    table_for order.payments do
      column Order::Payment.human_attribute_name(:created_at), :created_at
      column Order::Payment.human_attribute_name(:state), :state
      column Order::Payment.human_attribute_name(:payment_token), :payment_token
      column Order::Payment.human_attribute_name(:payer_token), :payer_token
      column Order::Payment.human_attribute_name(:payer_ip), :payer_ip
      column Order::Payment.human_attribute_name(:refund) do |payment|
        if payment.state == 'paid'
          link_to t('.refund'), refund_admin_order_path(payment: payment.id), method: :post, data: {confirm: 'Confirm.'}
        end
      end
    end

    h3 Order.human_attribute_name :messages
    table_for order.messages do
      column Message.human_attribute_name(:text), :text
      column Message.human_attribute_name(:created_at), :created_at
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
      sif.input(:country) +
      sif.input(:shipping_address_line1) +
      sif.input(:shipping_address_line2) +
      sif.input(:shipping_city) +
      sif.input(:shipping_state) +
      sif.input(:shipping_zip) + 
      sif.input(:phone_number)
    end
    f.actions
  end
end



