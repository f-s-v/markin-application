ActiveAdmin.register Product::Characteristic do
  menu parent: 'Store', label: 'Characteristics'

  config.filters = false
  
  controller do
    def permitted_params
      params.permit!
    end
  end
  
  index do
    selectable_column
    column :name do |c|
      link_to c.name.value, [:admin, c]
    end
    actions
  end

  show do
    attributes_table_for product_characteristic do
      row :name do
        product_characteristic.name.value
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :name, as: :formtastic_translated_text
      f.has_many :options do |inputs|
        inputs.input :name, as: :formtastic_translated_text
      end
    end
    f.actions
  end
end
