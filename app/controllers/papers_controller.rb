class PapersController < ApplicationController
  include Concerns::Letters
  
  respond_to :html
  
  let(:resource, on: :member) do
    Paper.includes(:title).where(public_id: params[:id]).first!
  end
  
  let(:collection, on: :collection) do
    Paper.order('created_at desc')
  end
  
  def index
    respond_with collection
  end
  
  def show
    respond_with resource
  end

end
