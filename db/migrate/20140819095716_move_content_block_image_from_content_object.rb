class MoveContentBlockImageFromContentObject < ActiveRecord::Migration
  def up
    add_column :content_blocks, :image, :string
    ContentBlock.where(block_style: 'image').each do |cb|
      cb.update_attributes image: cb.content['image']
    end
  end
end
