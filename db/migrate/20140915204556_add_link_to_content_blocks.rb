class AddLinkToContentBlocks < ActiveRecord::Migration
  def change
    add_column :content_blocks, :link, :string
  end
end
