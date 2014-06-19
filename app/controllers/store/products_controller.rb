class Store::ProductsController < Store::BaseController
  respond_to :html
  
  let(:resource, on: :member) do
    Product.includes(:batch, options: :characteristic).where(public_id: params[:id]).first!
  end
  let(:collection, on: :collection) { Product.all }

  def show
    respond_with resource
  end

  def index
    respond_with collection
  end
end
