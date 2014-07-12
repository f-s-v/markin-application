Rails.configuration.instance_eval do |config|
  config.content_blocks_background_styles = %w(gold black goldGradient blackGradient)
  config.content_blocks_border_styles = %w(white gold black)
  config.content_blocks_font_styles = %w(large condenced regular)
  config.content_blocks_image_styles = %w(centered background)
  config.content_blocks_block_styles = %w(text image embed spacer)
end
