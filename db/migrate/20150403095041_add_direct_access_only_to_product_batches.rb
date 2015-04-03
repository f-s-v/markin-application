class AddDirectAccessOnlyToProductBatches < ActiveRecord::Migration
  def change
    add_column :product_batches, :direct_access_only, :boolean, default: false
    Product::Batch.reset_column_information
    Product::Batch.update_all(direct_access_only: false)
  end
end
