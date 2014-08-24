ActiveAdmin.register Product::Batch do
  menu parent: 'Store', label: 'Batches'

  filter :name

  controller do
    def permitted_params
      params.permit!
    end
  end


  index do
    selectable_column
    column :name do |b|
      link_to b.name.value, [:admin, b]
    end
    actions
  end

  show do
    attributes_table_for product_batch do
      row :name do
        product_batch.name.value
      end
      row :poster do
        image_tag uploadcare_url(product_batch.poster, resize: 'x100')
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :name, as: :formtastic_translated_text
      f.input :poster, as: :formtastic_uploadcare
    end

    f.actions
  end
end
