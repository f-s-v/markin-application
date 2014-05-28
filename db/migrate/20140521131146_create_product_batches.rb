class CreateProductBatches < ActiveRecord::Migration
  def change
    create_table :product_batches do |t|
      t.string :name
      t.string :poster

      t.timestamps
    end
  end
end
