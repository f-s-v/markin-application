class Store::BatchesController < ApplicationController
  include Concerns::Letters
  
  respond_to :html
  
  let(:resource, on: :member) do
    Product::Batch.includes(:name).where(public_id: params[:id]).first!
  end
  
  let(:collection, on: :collection) do
    Product::Batch.joins(:name).where('translations.locale' => I18n.locale).order('translations.text')
  end
  
  let(:products, on: :member) do
    scope = resource.products.joins(:options).distinct
    scope = scope.where('product_characteristic_options.id' => params[:option]) if params[:option].present?
    scope
  end
  
  def index
    respond_with collection
  end
  
  def show
    respond_with resource
  end
end
