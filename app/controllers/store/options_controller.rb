class Store::OptionsController < ApplicationController
  include Concerns::Letters
  
  respond_to :html
  
  let(:resource, on: :member) do
    Product::Characteristic::Option.find(params[:id])
  end
  
  let(:products, on: :member) do
    resource.products.joins(:batch, :name).
      where('translations.locale' => I18n.locale).
      select('products.*, translations.text').
      order('translations.text').
      merge(Product::Batch.searchable).uniq.to_a
  end

  def show
    respond_with resource
  end
end
