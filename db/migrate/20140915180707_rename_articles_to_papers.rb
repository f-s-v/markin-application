class RenameArticlesToPapers < ActiveRecord::Migration
  def change
    rename_table :articles, :papers
  end
end
