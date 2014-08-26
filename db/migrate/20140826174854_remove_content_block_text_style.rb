class RemoveContentBlockTextStyle < ActiveRecord::Migration
  def up
    ContentBlock.where(font_style: 'large').each do |cb|
      cb.font_style = 'regular'
      cb.text.each do |translation|
        if translation.text.present?
          translation.update_attributes text: "#" + translation.text
        end
      end
      cb.save
    end
    ContentBlock.where(font_style: 'condenced').each do |cb|
      cb.font_style = 'regular'
      cb.text.each do |translation|
        if translation.text.present?
          translation.update_attributes text: "##" + translation.text
        end
      end
      cb.save
    end

  end
end
