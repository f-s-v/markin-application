ActiveAdmin.register Product::Characteristic do
  menu parent: 'Store', label: 'Characteristics'

  config.filters = false
  
  permit_params :name
  
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

  form do |f|
    f.inputs do
      f.input :name
    end
    f.actions
  end
end
