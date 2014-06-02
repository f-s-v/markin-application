class AddPublicIdToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :public_id, :string, index: true, unique: true
  end
end
