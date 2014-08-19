class MoveContentBlockCodeFromContentObject < ActiveRecord::Migration
  def up
    add_column :content_blocks, :embed_code, :text
    ContentBlock.where(block_style: 'embed').each do |cb|
      cb.update_attributes embed_code: cb.content['code']
    end
  end
end
