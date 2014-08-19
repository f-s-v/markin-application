class CreateTranslations < ActiveRecord::Migration
  def change
    create_table :translations do |t|
      t.string :locale
      t.text :text
      t.references :owner, index: true, polymorphic: true

      t.timestamps
    end
  end
end
