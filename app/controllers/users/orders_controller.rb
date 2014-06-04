class Users::OrdersController < ApplicationController
  before_action :authenticate_user!

  protected def resource
    @order ||= current_user.orders.completed.where(public_id: params[:id]).first
  end

  helper_method :resource
end
