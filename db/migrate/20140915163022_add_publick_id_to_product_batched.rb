class AddPublickIdToProductBatched < ActiveRecord::Migration
  def change
    add_column :product_batches, :public_id, :string, index: true
    
    Product::Batch.all.each do |b|
      b.update_attributes public_id: Product::Batch.generate_public_id(:public_id)
    end
  end
end
