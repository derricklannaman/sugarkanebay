module CartHelper
  def cart_quantity
    current_user.cart.orders.where(order_status: 'active').pluck(:total).sum if current_user.cart.present?
  end
end
