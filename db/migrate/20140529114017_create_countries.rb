class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :name
      t.string :code, index: true, unique: true

      t.timestamps
    end
  end
end
