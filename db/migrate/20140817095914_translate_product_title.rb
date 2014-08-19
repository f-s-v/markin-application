class TranslateProductTitle < ActiveRecord::Migration
  def up
    Product.all.each do |p|
      p.name.create(locale: I18n.locale, text: p.attributes['name'])
    end
  end
end
