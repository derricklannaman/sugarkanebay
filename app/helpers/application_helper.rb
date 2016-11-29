module ApplicationHelper
  def current_orders
    # @orders = current_user.cart.orders.where(order_status: 'active').sort if current_user.cart.present?
  end
end
