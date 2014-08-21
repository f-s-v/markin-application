class AddTextToContentBlock < ActiveRecord::Migration
  def up
    ContentBlock.where(block_style: 'text').each do |block|
      block.text.create(locale: I18n.locale, text: block.attributes['text'])
    end
  end
end
