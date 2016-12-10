module ApplicationHelper
  def current_orders
    # @orders = current_user.cart.orders.where(order_status: 'pending-payment').sort if current_user.cart.present?
  end

  def admin_page
    controller_name == 'admin'
  end
end
