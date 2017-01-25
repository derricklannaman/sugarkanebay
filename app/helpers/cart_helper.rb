module CartHelper
  def cart_quantity
    initial_cart_count_after_sign_in if cookies[:entry_point_url].present?
    current_user.cart.orders.where(order_status: 'pending-payment').pluck(:quantity).sum if current_user.cart.present?

  end

  def paid_amount amount
    amount.to_i / 100.to_f
  end

  def initial_cart_count_after_sign_in
    meal = Meal.find(params[:id])
    Order.create( user_id: current_user.id,
                  meal_id: params[:id].to_i,
                  cart_id: current_user.cart.id,
                  order_items: meal.name,
                  quantity: 1, total: meal.price )
  end
end
