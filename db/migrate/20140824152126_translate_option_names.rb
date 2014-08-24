class TranslateOptionNames < ActiveRecord::Migration
  def up
    Product::Characteristic::Option.all.each do |p|
      p.name.create(locale: I18n.locale, text: p.attributes['name'])
    end
    remove_column :product_characteristic_options, :name
  end
end
