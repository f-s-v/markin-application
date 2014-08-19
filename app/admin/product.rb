ActiveAdmin.register Product do

  menu parent: "Store"

  # filter :name
  filter :public_id, label: 'ID'
  filter :batch
  filter :price
  filter :poster
  filter :created_at
  filter :has_sizes

  before_filter only: [:create, :update] do
    params[:product][:content_blocks_attributes] = JSON.parse(params[:product][:content_blocks_attributes])
  end

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
      row :batch
      row :poster do
        image_tag uploadcare_url(product.poster, resize: 'x100')
      end
      row :created_at
      row :has_sizes
    end
  end


  form do |f|
    within @head do
      link href: asset_path('fullpicture-manage.html'), rel: 'import'
    end


    f.inputs f.object.class.human_attribute_name('name'), class: 'inputs translated' do
      (Rails.application.config.i18n_enabled_locales.map(&:to_s) - f.object.name.pluck(:locale)).each do |locale|
        f.object.name.build(locale: locale)
      end
      f.inputs for: :name do |inputs|
        inputs.input :text, as: :string, label: inputs.object.locale
      end
    end

    f.inputs do
      f.input :batch
      f.input :price
      f.input :poster, as: :formtastic_uploadcare
      f.input :has_sizes
      f.input :content_blocks_attributes, as: :formtastic_json, width: 20
    end

    Product::Characteristic.all.each do |c|
      f.inputs c.name do
        f.input :option_ids, as: :check_boxes, collection: c.options
      end
    end

    f.actions
  end

end
