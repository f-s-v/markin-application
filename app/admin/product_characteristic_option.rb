ActiveAdmin.register Product::Characteristic::Option do
  menu parent: 'Store', label: 'Options'

  filter :characteristic
  filter :name

  permit_params :name, :characteristic

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

  form do |f|
    f.inputs do
      f.input :name
      f.input :characteristic
    end
    f.actions
  end

end
