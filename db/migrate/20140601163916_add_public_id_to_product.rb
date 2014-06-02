class AddPublicIdToProduct < ActiveRecord::Migration
  def change
    add_column :products, :public_id, :string, index: true, unique: true
    Product.all.each do |p|
      p.generate_public_id(:public_id)
      p.save
    end
  end
end
