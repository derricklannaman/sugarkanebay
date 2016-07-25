class OrderController < ApplicationController
  def new
  end

  def create
    if params[:cart].present?
      cart = Cart.find(params[:cart])
      create_order_and_add_to_cart cart
    else
      cart = Cart.create!(user_id: current_user.id, item: '', price: '', quantity: '', total: '')
      create_order_and_add_to_cart cart
    end
    redirect_back fallback_location: shop_path
  end

  def create_order_and_add_to_cart cart
    order = Order.create( user_id: current_user.id, meal_id: params[:item_id].to_i,
                  cart_id: cart.id, order_items: params[:item_name])
    current_user.cart.item = order.order_items
    current_user.cart.save!
  end


end
