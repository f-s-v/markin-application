class TranslateBatchNames < ActiveRecord::Migration
  def up
    Product::Batch.all.each do |p|
      p.name.create(locale: I18n.locale, text: p.attributes['name'])
    end
    remove_column :product_batches, :name
  end
end
