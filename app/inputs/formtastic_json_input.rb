class FormtasticJsonInput < Formtastic::Inputs::StringInput
  def input_html_options
    super.merge(type: 'hidden', value: object.send(input_name.to_s.gsub(/_attributes$/, '')).to_json(only: [
      :id,
      :content,
      :width,
      :block_style,
      :padding,
      :font_style,
      :border_style,
      :background_style,
      :image_style,
      :order_number,
      :height,
    ]))
  end


  def to_html
    input_wrapping do
      canvas_source = "#{sanitized_object_name}_#{sanitized_method_name}"
      canvas_id = "fp#{sanitized_object_name.camelize}#{sanitized_method_name.camelize}Canvas"

      label_html <<
      builder.text_field(method, input_html_options) <<
      template.content_tag('fp-canvas', nil, source: canvas_source, id: canvas_id, width: input_options[:width]) <<
      template.content_tag('fp-opener', nil, canvas: canvas_id)
    end
  end
end