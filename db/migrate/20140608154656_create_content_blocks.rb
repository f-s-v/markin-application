class CreateContentBlocks < ActiveRecord::Migration
  def change
    create_table :content_blocks do |t|
      t.references :page, index: true, polymorphic: true
      t.json :content
      t.integer :width
      t.string :block_style
      t.boolean :padding
      t.string :font_style
      t.string :border_style
      t.string :background_style
      t.string :image_style
      
      t.timestamps
    end
  end
end
