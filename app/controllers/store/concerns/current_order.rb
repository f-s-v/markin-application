module Store::Concerns::CurrentOrder
  extend ActiveSupport::Concern

  included do 
    helper_method :current_order
  end

  protected def current_order
    @current_order ||= ::Order.where(public_id: cookies[:order_id]).first
  end

  protected def setup_current_order
    cookies[:order_id] = (current_order && current_order.public_id || Order.create.public_id)
  end

  protected def clean_current_order
    cookies[:order_id] = nil
  end
end