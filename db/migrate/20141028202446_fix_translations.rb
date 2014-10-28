class FixTranslations < ActiveRecord::Migration
  def change
    Translation.where(text: '').destroy_all
  end
end
