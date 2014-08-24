class FormtasticTranslatedTextInput < Formtastic::Inputs::StringInput
  def to_html
    (
      Rails.application.config.i18n_enabled_locales.map(&:to_s) - object.name.pluck(:locale)
    ).each do |locale|
      object.name.build(locale: locale)
    end

    builder.has_many attributized_method_name,
      new_record: false,
      allow_destroy: false,
      heading: humanized_method_name,
      class: 'translated-text-input' do |inputs|
      inputs.input :locale, as: :hidden
      inputs.input :text, as: :string, label: I18n.t("locale.#{inputs.object.locale}")
    end
  end
end