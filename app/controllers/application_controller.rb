class ApplicationController < ActionController::Base
  include Concerns::Letters
  
  include Store::Concerns::CurrentOrder
  before_filter :setup_current_order

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def raise_not_found
    raise ActionController::RoutingError.new("Not Found")
    # raise ActionController::RoutingError.new("Not Found")
  end

  def authenticate_admin!
    if current_user
       raise_not_found unless current_user.admin
    else
      authenticate_user!
    end
  end
end
