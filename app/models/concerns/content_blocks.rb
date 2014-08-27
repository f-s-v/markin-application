module Concerns
  module ContentBlocks
    extend ActiveSupport::Concern

    included do
      has_many :content_blocks, as: :page
      accepts_nested_attributes_for :content_blocks, allow_destroy: true
    end

    def copy_content_blocks_from
    end

    def copy_content_blocks_from=(url)
      return unless url.present?
      params = Rails.application.routes.recognize_path url


      resource = if self.class == Product && params[:controller] == 'store/products' && params[:action] == 'show'
        Product.where(public_id: params[:id]).first
      end
      return unless resource.present?

      self.content_blocks.destroy_all
      self.content_blocks << resource.content_blocks.map{|b| b.deep_clone include: :text}
      # resource.content_blocks.each do |block|
      #   duplicate = block.dup
      #   duplicate.text << block.text.map(&:dup)
      #   duplicate.page = self
      #   duplicate.save
      # end
    end 
  end
end