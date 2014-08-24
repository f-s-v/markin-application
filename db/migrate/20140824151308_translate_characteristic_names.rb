class TranslateCharacteristicNames < ActiveRecord::Migration
  def up
    Product::Characteristic.all.each do |p|
      p.name.create(locale: I18n.locale, text: p.attributes['name'])
    end
    remove_column :product_characteristics, :name
  end
end
