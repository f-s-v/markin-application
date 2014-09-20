class Store::ProductsController < Store::BaseController
  include Concerns::Letters

  respond_to :html
  
  let(:resource, on: :member) do
    Product.includes(:batch, options: :characteristic).where(public_id: params[:id]).first!
  end
  
  let(:see_also_products, on: 'show') { Product.limit(3).order('random()') }

  def show
    respond_with resource
  end
end
