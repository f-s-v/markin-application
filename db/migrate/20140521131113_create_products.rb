class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.references :batch, index: true
      t.decimal :price
      t.string :poster

      t.timestamps
    end
  end
end
