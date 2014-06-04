ActiveAdmin.register Product::Batch do
  menu parent: 'Store', label: 'Batches'

  filter :name

  permit_params :name, :poster

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
end
