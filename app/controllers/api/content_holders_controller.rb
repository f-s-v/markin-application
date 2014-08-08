class Api::ContentHoldersController < ApplicationController
  respond_to :json
  def index
    @content_blocks = ContentBlock.where(page_type: params[:page_type], page_id: params[:page_id]).order('order_number')
    respond_with @content_blocks
  end
end
