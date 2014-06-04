ActiveAdmin.register Product::Batch do
  menu parent: 'Store', label: 'Batches'

  filter :name

  index do
    selectable_column
    column :name do |b|
      link_to b.name, [:admin, b]
    end
    actions
  end

  show do
    attributes_table_for product_batch do
      row :name
      row :poster do
        image_tag uploadcare_url(product_batch.poster, resize: 'x100')
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :poster, as: :formtastic_uploadcare
    end

    f.actions
  end

  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
end
