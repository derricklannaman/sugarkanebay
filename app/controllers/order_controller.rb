class OrderController < ApplicationController
  before_action :authenticate_user!, only: :create

  def new
  end

  def create
    if current_user.cart.present?
      cart = current_user.cart
      order =  Order.find_or_create_by(order_items: params[:item_name])
      order.user_id = current_user.id if order.user_id.blank?
      order.meal_id = params[:item_id].to_i if order.meal_id.blank?
      order.cart_id = cart.id if order.cart_id.blank?
      order.quantity += 1
      order.save!
    else
      cart = Cart.create!(user_id: current_user.id, owner_name: current_user.firstname, price: '', quantity: '', total: '')
      current_user.cart = cart
      order = Order.create( user_id: current_user.id, meal_id: params[:item_id].to_i,
                    cart_id: cart.id, order_items: params[:item_name], quantity: 1)

      current_user.cart.owner_name = current_user.firstname
      current_user.cart.save!
    end
    flash[:notice] = "#{order.order_items} has been added to your cart"
    redirect_to shop_path
  end

  def add_item
    order = Order.find(params[:order_id])
    order.quantity += 1
    order.save!
    redirect_back fallback_location: cart_path(current_user.cart)
  end

  def subtract_item
    order = Order.find(params[:order_id])
    if order.quantity == 1
      order.destroy
      flash[:notice] = "#{order.order_items} has been removed from your cart"
    else
      order.quantity -= 1
      order.save!
    end
    redirect_back fallback_location: cart_path(current_user.cart)
  end

end
