class SetContentBlocksDefaultAttributes < ActiveRecord::Migration
  def up
    change_column :content_blocks, :padding, :boolean, default: false
    change_column :content_blocks, :stretch_height, :boolean, default: false
  end
end
