class CartController < ApplicationController
  before_action :authenticate_user!
  before_action :check_cart_exist, only: :show

  def show
    order = current_user.cart.orders.where(order_status: "pending-payment").first if current_user.cart.present?
    return if order.nil?
    order_item_info = []
    order.order_items.each do |order|
      meal = Meal.find(order.meal_id)
      order_item_info << { name: meal.name, image: meal.thumbnail_image }
    end
    @orders = order.order_items.to_a.zip(order_item_info)
    cart_total
  end

  def checkout
    @orders = current_user.cart.orders.where(order_status: "pending-payment").sort
    cart_total
  end

  def account
    if current_user.cart.present?
      @orders = current_user.cart.orders.where(order_status: "pending-payment").sort
      preshipped_orders = current_user.orders.where(order_status: "pending-shipping").first.order_items
      order_item_info = []
      preshipped_orders.each do |order|
        meal = Meal.find(order.meal_id)
        order_item_info << { name: meal.name, image: meal.thumbnail_image }
      end
      @preshipped_orders = preshipped_orders.zip(order_item_info)
    end
  end

  def load_cart
    orders = current_user.orders.first.order_items.sort
    order_data = []
    orders.each do |order|
      meal = Meal.find(order.meal_id)
      order_data << { name: meal.name, quantity: order.quantity, image: meal.thumbnail_image }
    end
    render json: order_data
  end

  def cart_total
    unless current_user.cart.blank?
      # binding.pry
      cart_total = current_user.cart.orders.where(order_status: "pending-payment").pluck(:total).sum
      current_user.cart.total = cart_total
      current_user.cart.save!
      @cart_total = current_user.cart.total
    end
  end

  def check_cart_exist
    # TODO: fix
    if current_user.cart.present?
      if current_user.cart.id != cart_path.split('/').last.to_i
        redirect_to shop_path
      end
    end
  end

end
