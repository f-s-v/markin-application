class Store::OptionsController < ApplicationController
  include Concerns::Letters
  
  respond_to :html
  
  let(:resource, on: :member) do
    Product::Characteristic::Option.find(params[:id])
  end
  
  let(:products, on: :member) do
    resource.products.joins(:name).where('translations.locale' => I18n.locale).order('translations.text').to_a.uniq
  end

  def show
    respond_with resource
  end
end
