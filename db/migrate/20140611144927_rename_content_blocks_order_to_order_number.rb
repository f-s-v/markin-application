class RenameContentBlocksOrderToOrderNumber < ActiveRecord::Migration
  def change
    rename_column :content_blocks, :order, :order_number
  end
end
