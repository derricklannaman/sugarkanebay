class OrderController < ApplicationController
  before_action :return_to_order_url, only: :create
  before_action :authenticate_user!, only: :create

  def new
  end

  def create
    if current_user.cart.present?
      cart = current_user.cart
      meal = Meal.find(params[:meal_id])
      if current_user.orders.any?
        order = current_user.orders.where(order_status: 'pending-payment').where(meal_id: params[:meal_id]).first
        # If no order is found for that meal id
        order = Order.create( user_id: current_user.id,
                              meal_id: params[:meal_id].to_i,
                              cart_id: cart.id,
                              order_items: params[:meal_name],
                              quantity: 0,
                              guid: SecureRandom.hex(10),
                              total: meal.price) if order.blank?
      else
        # If there are no current orders, create a new order
        order = Order.create( user_id: current_user.id,
                              meal_id: params[:meal_id].to_i,
                              cart_id: cart.id,
                              order_items: params[:meal_name],
                              guid: SecureRandom.hex(10),
                              quantity: 0, total: meal.price)
      end
      if params[:quantity].present?
        count = order.quantity += params[:quantity].to_i
      else
        count =  order.quantity += 1
      end
      order.total = meal.price * count
      order.save!
      flash[:notice] = "#{order.order_items} has been added to your cart"
      redirect_to shop_path
    else
      flash[:notice] = "Please sign up or sign in first."
      redirect_to new_user_registration_path(redirect_to: request.path)
    end
  end

  def add_item
    order = Order.find(params[:order_id])
    meal = Meal.find(order.meal_id)
    count = order.quantity += 1
    order.total = meal.price * count
    order.save!
    redirect_back fallback_location: cart_path(current_user.cart)
  end

  def subtract_item
    order = Order.find(params[:order_id])
    meal = Meal.find(order.meal_id)
    if order.quantity == 1
      order.destroy
      flash[:notice] = "#{order.order_items} has been removed from your cart"
    else
      count = order.quantity -= 1
      order.total = meal.price * count
      order.save!
    end
    redirect_back fallback_location: cart_path(current_user.cart)
  end

  def shipped
    order = Order.find(params[:order_id])
    order.order_status = 'shipped'
    order.order_shipped_date = Time.zone.now.strftime("%m/%d/%Y")
    # binding.pry
    order.save!
    redirect_back fallback_location: daily_orders_path
  end

  def return_to_order_url
    return if current_user.present? && cookies[:entry_point_url].blank?
    # if current_user.blank? && cookies[:entry_point_url].present?
    #   initial_cart_with_first_order_after_sign_in
    # end
    if current_user.present?
      cookies.delete :entry_point_url
    else
      cookies[:entry_point_url] = ''
      cookies[:entry_point_url] = request.referer
    end
  end

  def initial_cart_with_first_order_after_sign_in
    meal = Meal.find(params[:meal_id])
    Order.create( user_id: current_user.id,
                  meal_id: params[:id].to_i,
                  cart_id: current_user.cart.id,
                  order_items: meal.name,
                  guid: SecureRandom.hex(10),
                  quantity: 1, total: meal.price )
  end

end
