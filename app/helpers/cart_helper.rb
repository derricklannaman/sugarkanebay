module CartHelper
  def cart_quantity
    current_user.cart.orders.pluck(:quantity).sum if current_user.cart.present?
  end
end
