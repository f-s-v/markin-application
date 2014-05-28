class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method def cart
    @cart ||= Order.where(id: session[:cart_id]).first
    @cart ||= Order.create
    session[:cart_id] = @cart.id
    @cart
  end
end
