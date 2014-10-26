ActiveAdmin.register Page do
  config.filters = false

  controller do
    def scoped_collection
      Page.includes(:content_blocks)
    end

    def permitted_params
      params.permit!
    end
  end

  index do
    selectable_column
    column :slug do |c|
      link_to c.slug, [:admin, c]
    end
    column :title do |c|
      c.title.value
    end
    actions
  end

  show do
    attributes_table_for page do
      row :slug
      row :title do
        page.title.value
      end
      row :description do
        page.description.value
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :slug
      f.input :title, as: :formtastic_translated_text
      f.input :description, as: :formtastic_translated_text
      f.input :content_blocks, as: :formtastic_content_blocks, width: 24
      # f.input :copy_content_blocks_from
    end

    f.actions
  end

end
