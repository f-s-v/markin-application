module Store::Concerns::CurrentOrder
  extend ActiveSupport::Concern

  included do 
    helper_method :current_order
  end

  protected def current_order
    @current_order ||= ::Order.where(public_id: session[:order_id]).first
  end

  protected def setup_current_order
    order = current_order || Order.create
    session[:order_id] = order.public_id
  end

  protected def clean_current_order
    session[:order_id] = nil
  end
end