class AddOpenLinkInNewTabToContentBlock < ActiveRecord::Migration
  def change
    add_column :content_blocks, :open_link_in_new_tab, :boolean, default: false
  end
end
