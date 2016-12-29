class CartController < ApplicationController
  before_action :authenticate_user!
  before_action :check_cart_exist, only: :show

  def show
    @orders = current_user.cart.orders.where(order_status: "pending-payment").sort if current_user.cart.present?
    cart_total
  end

  def checkout
    @orders = current_user.cart.orders.where(order_status: "pending-payment").sort
    cart_total
  end

  def account
    if current_user.cart.present?
      @orders = current_user.cart.orders.where(order_status: "pending-payment").sort
      previous_orders = current_user.cart.orders.where(order_status: "pending-shipping").order(created_at: :desc)
      @prev_orders = previous_orders.group_by { |order| order.created_at.to_date }.to_a
    end
  end

  def load_cart
    orders = current_user.cart.orders.where(order_status: "pending-payment").sort
    order_data = []
    orders.each do |order|
      order_data << { name: order.order_items, quantity: order.quantity, image: Meal.find(order.meal_id).thumbnail_image }
    end
    render json: order_data
  end

  def cart_total
    unless current_user.cart.blank?
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
