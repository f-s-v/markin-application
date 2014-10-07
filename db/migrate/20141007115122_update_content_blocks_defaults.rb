class UpdateContentBlocksDefaults < ActiveRecord::Migration
  def change
    change_column_default :content_blocks, :border_style, "white"
  end
end