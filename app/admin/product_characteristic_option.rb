ActiveAdmin.register Product::Characteristic::Option do
  menu parent: 'Store', label: 'Options'

  filter :characteristic
  filter :name

  index do
    selectable_column
    column :name do |c|
      link_to c.name, [:admin, c]
    end
    column :characteristic
    actions
  end

  show do
    attributes_table_for product_characteristic_option do
      row :name
    end
  end
end
