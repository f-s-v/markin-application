class FormtasticContentBlocksInput < Formtastic::Inputs::StringInput
  def to_html
    input_wrapping do
      canvas_source = "#{sanitized_object_name}_#{sanitized_method_name}"
      canvas_id = "fp#{sanitized_object_name.camelize}#{sanitized_method_name.camelize}Canvas"

      label_html << template.raw('<lib-monitormedia id="mediaMonitor">
        <lib-monitormedia-rule name="small" max-width="630px"></lib-monitormedia-rule>
        <lib-monitormedia-rule name="medium" max-width="910px"></lib-monitormedia-rule>
        <lib-monitormedia-rule name="large" min-width="911px"></lib-monitormedia-rule>
      </lib-monitormedia>') <<
      template.content_tag(
        'fp-canvas', nil,
        source: canvas_source, id: canvas_id,
        width: input_options[:width], owner: object.class.name.downcase.gsub('::', '_')
      ) <<
      template.content_tag('fp-opener', nil, canvas: canvas_id) <<
      builder.fields_for(:content_blocks) do |cb_inputs|
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
        cb_inputs.hidden_field(:image) <<
        cb_inputs.hidden_field(:embed_code) <<
        cb_inputs.hidden_field(:link) <<
        cb_inputs.fields_for(:text) do |tx_inputs|
          tx_inputs.hidden_field(:locale) <<
          tx_inputs.hidden_field(:text)
        end
      end
    end
  end
end