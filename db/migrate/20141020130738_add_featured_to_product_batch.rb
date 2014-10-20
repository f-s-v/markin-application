class AddFeaturedToProductBatch < ActiveRecord::Migration
  def change
    add_column :product_batches, :featured, :boolean, default: false
  end
end
