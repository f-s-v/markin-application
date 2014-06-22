class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :receiver, polymorphic: true, index: true
      t.string :code, index: true
      t.timestamps
    end
  end
end
