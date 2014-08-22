json.array! @content_blocks do |block|
  json.order_number block.order_number
  json.width block.width
  json.block_style block.block_style
  json.padding block.padding
  json.font_style block.font_style
  json.border_style block.border_style
  json.background_style block.background_style
  json.image_style block.image_style
  json.stretch_height block.stretch_height
  json.image block.image
  json.embed_code block.embed_code
  json.text_attributes do
    json.array! block.text do |text|
      json.locale text.locale
      json.text text.text
    end
  end
end
