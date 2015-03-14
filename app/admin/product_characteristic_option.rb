ActiveAdmin.register Product::Characteristic::Option do
  menu parent: 'Store'

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
    actions only: [:view]
  end

  form do |f|
    f.inputs do
      f.input :name, as: :formtastic_translated_text
      f.input :content_blocks, as: :formtastic_content_blocks, width: 20
    end      
    f.actions
  end  
  
end
