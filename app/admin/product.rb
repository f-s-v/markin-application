ActiveAdmin.register Product do

  menu parent: "Store"

  # filter :name
  filter :public_id, label: 'ID'
  filter :batch, member_label: :to_s
  filter :price
  filter :price_by_request
  filter :created_at

  controller do
    defaults finder: :find_by_public_id!

    def permitted_params
      params.permit!
    end
  end

  index do
    selectable_column
    column 'ID' do |product|
      link_to [:admin, product] do
        content_tag 'nobr', product.public_id
      end
    end

    column :name do |product|
      product.name.value
    end
    column :batch
    column :price do |product|
      number_to_currency product.price, precision: 0, locale: :en
    end
    column :price_rub do |product|
      number_to_currency (product.price_rub || product.converted_price), precision: 0, locale: :ru
    end
    column :price_by_request
    column :created_at
    actions
  end


  show  do
    attributes_table_for product do
      row "ID" do
        product.public_id
      end
      row :price do
        number_to_currency product.price, locale: :en
      end
      row :price_rub do
        number_to_currency (product.price_rub || product.converted_price), locale: :ru
      end
      row :price_by_request
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
      # f.input :copy_content_blocks_from
      f.input :batch, member_label: :to_s
      # f.input :price_by_request      
      f.input :price
      f.input :price_rub
      f.input :poster, as: :formtastic_uploadcare
      f.input :has_sizes
    end

    Product::Characteristic.all.each do |c|
      f.inputs c.name.value do
        f.input :option_ids,
          as: :check_boxes, collection: c.options,
          member_label: :to_s, label: I18n.t('irregular.option_ids')
      end
    end

    f.actions
  end

end
