# Application Controller
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    create_order_on_initial_signup
    cookies[:entry_point_url] || stored_location_for(resource) ||
      request.referer || root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:firstname])
  end

  def number_of_items_in_cart
    if current_user.cart.present? && current_user.orders.present?
      current_user.orders.first.order_items.sum(:quantity)
      # binding.pry
      # if current_user.orders.first.order_status == "pending-payment"
      #   current_user.orders.where(order_status: 'pending-payment').first.order_items.sum(:quantity)
      # else
      #   0
      # end
    else
      0
    end
  end

  def create_order_on_initial_signup
    return if cookies[:entry_point_url].blank? && cookies[:entry_point_quantity].blank?
    meal = Meal.find(cookies[:entry_point_url].split('/').last)
    init_qty = cookies[:entry_point_quantity]
    order = Order.create( user_id: current_user.id,
                          cart_id: current_user.cart.id,
                          guid: SecureRandom.hex(10),
                          quantity: init_qty,
                          total: meal.price * init_qty.to_i)
    order_item = OrderItem.create(order_id: order.id, meal_id: meal.id,
                                  quantity: init_qty,
                                  total_price: meal.price * init_qty.to_i || 0)

  end

  helper_method :number_of_items_in_cart
end
