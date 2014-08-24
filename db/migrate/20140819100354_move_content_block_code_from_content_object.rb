class MoveContentBlockCodeFromContentObject < ActiveRecord::Migration
  def up
    add_column :content_blocks, :embed_code, :text
    ContentBlock.reset_column_information
    ContentBlock.where(block_style: 'embed').each do |cb|
      cb.embed_code = cb.attributes["content"]["code"]
      cb.save
    end
  end
end
