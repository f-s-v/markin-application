ActiveAdmin.register Page do
  filter :slug
  filter :title

  permit_params :title, :slug, content_blocks_attributes: [
    :id, :_destroy,
    :content, :width, :height, :block_style,
    :image_style, :font_style, :border_style,
    :background_style, :padding, :order,
  ]

  index do
    selectable_column
    column :slug do |c|
      link_to c.slug, [:admin, c]
    end
    column :title
    actions
  end

  show do
    attributes_table_for page do
      row :slug
      row :title
    end
  end

  form do |f|
    f.inputs do
      f.input :slug
      f.input :title
    end


    f.inputs do
      f.has_many :content_blocks, :allow_destroy => true, :heading => 'Content' do |cf|
        cf.input :content, as: :text
        cf.input :width
        cf.input :height
        %w(block image font border background).each do |attr|
          cf.input "#{attr}_style",
            as: :select,
            collection: Rails.configuration.send("content_blocks_#{attr}_styles")
        end
        cf.input :padding
        cf.input :order_number
      end
    end

    f.actions
  end

end
