ActiveAdmin.register Product::Characteristic do
  menu parent: 'Store', label: 'Characteristics'

  config.filters = false

  index do
    selectable_column
    column :name do |c|
      link_to c.name, [:admin, c]
    end
    actions
  end

  show do
    attributes_table_for product_characteristic do
      row :name
    end
  end


end
