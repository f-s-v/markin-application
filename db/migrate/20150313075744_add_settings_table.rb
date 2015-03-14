class AddSettingsTable < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.float :usd_rub
    end
  end
end
