class AddOrderToContentBlock < ActiveRecord::Migration
  def change
    add_column :content_blocks, :order, :integer
  end
end
