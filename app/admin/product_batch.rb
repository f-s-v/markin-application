ActiveAdmin.register Product::Batch do
  menu parent: 'Store'

  filter :name

  controller do
    defaults finder: :find_by_public_id!

    def scoped_collection
      ::Product::Batch.includes(:content_blocks)
    end

    def permitted_params
      params.permit!
    end
  end

  index do
    selectable_column
    column 'ID' do |batch|
      link_to batch.public_id, [:admin, batch]
    end
    column :name do |b|
      link_to b.name.value, [:admin, b]
    end
    column :featured
    column :direct_access_only
    actions
  end

  show do
    attributes_table_for product_batch do
      row "ID" do
        product_batch.public_id
      end
      row :name do
        product_batch.name.value
      end
      row :description do
        product_batch.description.value
      end
      row :featured
      row :direct_access_only
      row :poster do
        image_tag uploadcare_url(product_batch.poster, resize: 'x100')
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :name, as: :formtastic_translated_text
      f.input :description, as: :formtastic_translated_text
      f.input :poster, as: :formtastic_uploadcare
      f.input :content_blocks, as: :formtastic_content_blocks, width: 20
      f.input :featured
      f.input :direct_access_only
    end

    f.actions
  end
end
