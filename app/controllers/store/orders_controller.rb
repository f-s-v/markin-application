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
      items_attributes: [
        :id,
        :amount,
        :size,
        :_destroy
      ]
    )
  end
end
