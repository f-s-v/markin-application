class AddPosterToPapers < ActiveRecord::Migration
  def change
    add_column :papers, :poster, :string
  end
end
