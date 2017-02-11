module CartHelper
  def cart_quantity
    current_user.orders.first.quantity if current_user.cart.present?
  end

  def paid_amount amount
    amount.to_i / 100.to_f
  end
end
