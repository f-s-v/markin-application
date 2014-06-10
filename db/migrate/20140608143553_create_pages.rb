class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.string :slug, index: true, unique: true

      t.timestamps
    end
  end
end
