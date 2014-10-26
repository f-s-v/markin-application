class AddPublishedAtToPapers < ActiveRecord::Migration
  def change
    add_column :papers, :published_at, :datetime
    Paper.all.each do |p|
      p.update_attributes published_at: p.created_at
    end
  end
end
