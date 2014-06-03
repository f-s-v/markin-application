class Store::OrdersController < Store::BaseController
  respond_to :html

  def update
    current_order.update_attributes order_params
    respond_with current_order, location: store_order_path
  end

  def destroy
    current_order.destroy
    redirect_to root_path
  end

  protected def order_params
    params.require(:order).permit(
      :country_id,
      :shipping_address_line1,
      :shipping_address_line2,
      :shipping_city,
      :shipping_state,
      :shipping_zip,
      :phone_number,
      items_attributes: [
        :id,
        :amount,
        :size,
        :_destroy
      ]
    )
  end
end
