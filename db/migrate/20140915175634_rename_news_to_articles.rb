class RenameNewsToArticles < ActiveRecord::Migration
  def change
    rename_table :news_items, :articles
  end
end
