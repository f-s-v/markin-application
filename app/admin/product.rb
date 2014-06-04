ActiveAdmin.register Product do

  menu parent: "Store"

  filter :name
  filter :public_id, label: 'ID'
  filter :batch
  filter :price
  filter :poster
  filter :created_at
  filter :has_sizes

  controller do
    defaults finder: :find_by_public_id!
  end

  index do
    selectable_column
    column 'ID' do |product|
      link_to product.public_id, [:admin, product]
    end

    column :name
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
      row :name
      row :batch
      row :poster do
        image_tag uploadcare_url(product.poster, resize: 'x100')
      end
      row :created_at
      row :has_sizes
      row :options_description
    end
  end


  form do |f|
    f.inputs do
      f.input :name
      f.input :batch
      f.input :price
      f.input :poster, as: :formtastic_uploadcare
      f.input :has_sizes
    end

    Product::Characteristic.all.each do |c|
      f.inputs c.name do
        f.input :option_ids, as: :check_boxes, collection: c.options
      end
    end

    f.actions
  end

  permit_params :name, :batch_id, :price, :poster, :has_sizes, :option_ids

  # index do
  # end
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
