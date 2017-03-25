# Application Controller
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    cookies[:entry_point_url] || stored_location_for(resource) ||
      request.referer || root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:firstname])
  end

  def number_of_items_in_cart
    if current_user.cart.present? && current_user.orders.present?
      current_user.orders.first.quantity
    else
      0
    end
  end

  helper_method :number_of_items_in_cart
end
