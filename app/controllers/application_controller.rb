class ApplicationController < ActionController::Base
  include Store::Concerns::CurrentOrder
  before_filter :setup_current_order

  before_filter :set_application_locale
  before_filter :set_url_locale

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def default_url_options(options={})
    { :locale => I18n.locale }
  end

  protected

  def set_application_locale
    if params[:locale].present?
      cookies[:locale] = I18n.locale = params[:locale]
    else
      # default_locale = request.location.data["country_code"].downcase == 'ru' ? :ru : I18n.default_locale
      default_locale = I18n.default_locale
      redirect_to url_for(locale: cookies[:locale].presence || default_locale), status: :moved_permanently
    end
  end

  def set_url_locale
    Rails.application.config.action_controller.default_url_options ||= {}
    Rails.application.config.action_controller.default_url_options[:locale] = I18n.locale
  end

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
