class TranslatePageTitle < ActiveRecord::Migration
  def change
    def up
      Page.all.each do |p|
        p.title.create(locale: I18n.locale, text: p.attributes['title'])
      end
      remove_column :pages, :title
    end
  end
end
