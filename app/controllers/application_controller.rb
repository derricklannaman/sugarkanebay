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

  # def return_to_order_url
  #   # binding.pry
  #   return if current_user.present? && cookies[:entry_point_url].blank?
  #   if current_user.blank? && cookies[:entry_point_url].present?
  #     initial_cart_with_first_order_after_sign_in
  #   end
  #   if current_user.present?
  #     binding.pry
  #     cookies.delete :entry_point_url
  #   else
  #     binding.pry
  #     cookies[:entry_point_url] = ''
  #     cookies[:entry_point_url] = request.referer
  #   end
  # end

  # def initial_cart_with_first_order_after_sign_in
  #   binding.pry
  #   # meal = Meal.find(params[:meal_id])
  #   # Order.create( user_id: current_user.id,
  #   #               meal_id: params[:id].to_i,
  #   #               cart_id: current_user.cart.id,
  #   #               order_items: meal.name,
  #   #               guid: SecureRandom.hex(10),
  #   #               quantity: 1, total: meal.price )
  # end

  helper_method :number_of_items_in_cart

end
