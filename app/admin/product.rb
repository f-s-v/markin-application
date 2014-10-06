ActiveAdmin.register Product do

  menu parent: "Store"

  # filter :name
  filter :public_id, label: 'ID'
  filter :batch
  filter :price
  filter :poster
  filter :created_at
  filter :has_sizes

  controller do
    defaults finder: :find_by_public_id!

    def permitted_params
      params.permit!
    end
  end

  index do
    selectable_column
    column 'ID' do |product|
      link_to product.public_id, [:admin, product]
    end

    column :name do |product|
      product.name.value
    end
    column :batch
    column :price do |product|
      number_to_currency product.price
    end
    column :created_at
    column :has_sizes
    actions
  end


  show  do
    attributes_table_for product do
      row "ID" do
        product.public_id
      end
      row :price do
        number_to_currency product.price
      end
      row :name do
        product.name.value
      end
      row :description do
        product.description.value
      end
      row :batch
      row :poster do
        image_tag uploadcare_url(product.poster, resize: 'x100')
      end
      row :created_at
      row :has_sizes
    end
  end


  form do |f|
    f.inputs do
      f.input :name, as: :formtastic_translated_text
      f.input :description, as: :formtastic_translated_text
      f.input :content_blocks, as: :formtastic_content_blocks, width: 20
      f.input :copy_content_blocks_from
      f.input :batch, member_label: :to_s
      f.input :price
      f.input :poster, as: :formtastic_uploadcare
      f.input :has_sizes
    end

    Product::Characteristic.all.each do |c|
      f.inputs c.name.value do
        f.input :option_ids, as: :check_boxes, collection: c.options, member_label: :to_s
      end
    end

    f.actions
  end

end
