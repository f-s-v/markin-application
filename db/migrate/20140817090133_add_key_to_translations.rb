class AddKeyToTranslations < ActiveRecord::Migration
  def change
    add_column :translations, :key, :string, index: true
  end
end
