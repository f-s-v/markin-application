class Store::OrdersController < Store::BaseController
  respond_to :html

  def update
    current_order.update_attributes order_params
    location = current_order.shipping_info.present? ? [:store, :order] : new_store_order_shipping_info_path
    respond_with current_order, location: location
  end

  def destroy
    current_order.destroy
    redirect_to root_path
  end

  protected def order_params
    params.require(:order).permit(
      items_attributes: [
        :id,
        :amount,
        :currency,
        :size,
        :_destroy
      ]
    )
  end
end
