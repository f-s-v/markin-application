ActiveAdmin.register Page do
  filter :slug
  filter :title

  before_filter only: [:create, :update] do
    params[:page][:content_blocks_attributes] = JSON.parse(params[:page][:content_blocks_attributes])
  end

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
    within @head do
      link href: asset_path('fullpicture-manage.html'), rel: 'import'
    end

    f.inputs do
      f.input :slug
      f.input :title
      f.input :content_blocks_attributes, as: :formtastic_json, width: 24
    end
    f.actions
  end

end
