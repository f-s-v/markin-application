class CreateNewsItems < ActiveRecord::Migration
  def change
    create_table :news_items do |t|
      t.string :public_id, index: true

      t.timestamps
    end
  end
end
