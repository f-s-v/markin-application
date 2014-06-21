class Store::Order::ItemsController < Store::BaseController

  respond_to :html

  def create
    item = current_order.items.create(item_params)
    redirect_to [:edit, :store, current_order]
  end

  protected def resource
    @item ||= current_order.items.find(params[:id])
  end

  protected def item_params
    params.permit :size, :amount, :product_public_id
  end
end
