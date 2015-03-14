ActiveAdmin.register Order::DeliveryZone do
  menu parent: 'Store'

  config.filters = false

  permit_params :name, :delivery_price, country_ids: []

  index do
    selectable_column
    column :name do |b|
      link_to b.name, [:admin, b]
    end
    actions
  end

  show do
    attributes_table_for order_delivery_zone do
      row :name
      row :delivery_price do |zone|
        number_to_currency zone.delivery_price, locale: :en
      end
      row :countries do |zone|
        zone.countries.map(&:name).join(', ')
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :delivery_price
      f.input :country_ids, collection: Country.all, :input_html => { :multiple => true }
    end

    f.actions
  end

end
