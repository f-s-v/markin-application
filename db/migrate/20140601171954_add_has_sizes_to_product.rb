class AddHasSizesToProduct < ActiveRecord::Migration
  def change
    add_column :products, :has_sizes, :boolean
  end
end
