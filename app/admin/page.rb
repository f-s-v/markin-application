ActiveAdmin.register Page do
  filter :slug
  filter :title

  # before_filter only: [:create, :update] do
  #   params[:page][:content_blocks_attributes] = JSON.parse(params[:page][:content_blocks_attributes])
  # end

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
      script raw("
        I18n.defaultLocale = #{I18n.locale.to_json};
        I18n.locale = I18n.defaultLocale;
        I18n.enabledLocales = #{Rails.application.config.i18n_enabled_locales.to_json};
      ")
    end

    f.inputs do
      f.input :slug
      f.input :title
      f.input :content_blocks_attributes, as: :formtastic_json, width: 24
    end

    f.inputs do
      f.fields_for :content_blocks do |cb_inputs|
        (Rails.application.config.i18n_enabled_locales.map(&:to_s) - cb_inputs.object.text.pluck(:locale)).each do |locale|
          cb_inputs.object.text.build(locale: locale)
        end

        cb_inputs.hidden_field(:width) <<
        cb_inputs.hidden_field(:block_style) <<
        cb_inputs.hidden_field(:padding) <<
        cb_inputs.hidden_field(:stretch_height) <<
        cb_inputs.hidden_field(:font_style) <<
        cb_inputs.hidden_field(:border_style) <<
        cb_inputs.hidden_field(:background_style) <<
        cb_inputs.hidden_field(:image_style) <<
        cb_inputs.hidden_field(:order_number) <<
        cb_inputs.hidden_field(:height) <<
        cb_inputs.fields_for(:text) do |tx_inputs|
          tx_inputs.hidden_field(:locale) <<
          tx_inputs.hidden_field(:text)
        end
      end
    end

    f.actions
  end

end
