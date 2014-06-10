module ApplicationHelper
  def expand_class(prefix = nil, value)
    if value.is_a? Hash
      value.map do |k, v|
        expand_class [prefix, k.to_s.dasherize].compact.join('-'), v
      end.join(' ')
    elsif value.is_a? Array
      value.map do |v|
        expand_class prefix, v.to_s.dasherize
      end.join(' ')
    else
      classes = value.to_s.split(' ')
      if classes.size > 1
        expand_class prefix, classes
      else
        [prefix, value].compact.join('-')
      end
    end
  end

  def checked_link_to(name=nil, url_options=nil, html_options={}, &block)
    html_options['checked'] = current_page?(url_options)
    link_to(name, url_options, html_options, &block)
  end

  def content_block_styles(block)
    styles = %w(block image font border background).map do |a|
      style = block.send("#{a}_style")
      style.present? ? [a, style].join('-') : nil
    end.compact

    styles << 'padding' if block.padding
    styles
  end
end
