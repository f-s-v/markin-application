class Store::Cart::ItemsController < ApplicationController

  respond_to :html

  def create
    cart.items.create(product_id: params[:product_id])
    redirect_to store_product_path(params[:product_id])
  end

  def destroy
    resource.destroy
    redirect_to store_cart_path
  end

  def increase
    resource.update_attributes amount: resource.amount + 1
    redirect_to store_cart_path
  end

  def decrease
    resource.update_attributes amount: resource.amount - 1
    redirect_to store_cart_path
  end

  protected def resource
    @item ||= cart.items.find(params[:id])
  end
end
