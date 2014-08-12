class AddStretchHeightToContentBlock < ActiveRecord::Migration
  def change
    add_column :content_blocks, :stretch_height, :boolean
  end
end
