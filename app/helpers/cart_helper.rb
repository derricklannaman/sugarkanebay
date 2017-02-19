module CartHelper
  def cart_quantity
    if current_user.cart.present? && current_user.orders.blank?
      0
    else
      current_user.orders.pluck(:quantity).first
    end
  end

  def paid_amount amount
    amount.to_i / 100.to_f
  end
end
