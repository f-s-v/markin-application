class Store::PaymentsController < Store::BaseController
  before_action :authenticate_user!

  def new
    raise ActiveRecord::RecordNotFound unless current_order.ready_to_checkout? and current_order.valid?
    current_order.update_attributes user: current_user
    payment = Order::Payment.create_for_order(current_order, request.remote_ip)
    redirect_to payment.checkout_url
  end

  def pay
    resource.process
    if resource.state == 'paid'
      clean_current_order
      redirect_to users_profile_order_path(resource.order.public_id)
    else
      redirect_to store_order_url
    end
  end

  def cancel
    resource.canceled!
    redirect_to store_order_url
  end

  protected def resource
    @payment ||= Order::Payment.joins(:order).where(
      orders: {user_id: current_user},
      payment_token: params[:token]
    ).first!
  end
end
