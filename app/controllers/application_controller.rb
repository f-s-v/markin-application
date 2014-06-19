class ApplicationController < ActionController::Base
  include Concerns::Letters
  
  include Store::Concerns::CurrentOrder
  before_filter :setup_current_order

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
