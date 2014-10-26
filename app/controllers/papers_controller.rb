class PapersController < ApplicationController
  include Concerns::Letters
  
  respond_to :html
  
  let(:resource, on: :member) do
    Paper.published.includes(:title).where(public_id: params[:id]).first!
  end
  
  let(:collection, on: :collection) do
    Paper.recent.published
  end
  
  def index
    respond_with collection
  end
  
  def show
    respond_with resource
  end

end
