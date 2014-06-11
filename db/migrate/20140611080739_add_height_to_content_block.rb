class AddHeightToContentBlock < ActiveRecord::Migration
  def change
    add_column :content_blocks, :height, :integer
  end
end
