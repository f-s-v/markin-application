ActiveAdmin.register Page do
  filter :slug
  filter :title

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
      f.input :content_blocks, as: :formtastic_content_blocks, width: 24
    end

    f.actions
  end

end
