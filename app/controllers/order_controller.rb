class OrderController < ApplicationController
  before_action :return_to_order_url, only: :create
  before_action :authenticate_user!, only: :create

  def new
  end

  def create
    if current_user.cart.present?
      cart = current_user.cart
      meal = Meal.find(params[:meal_id])
      requested_quantity = params[:quantity].to_i
      requested_meal = params[:meal_id].to_i

      if current_user.orders.present?
        order = current_user.orders.first
        order_item = order.order_items.select { |item| item.meal_id == requested_meal }
        if order_item.any?
          # Update the ordered item in existing order
          order_item = order_item.first
          order_item.quantity += requested_quantity
          order_item.total_price += requested_quantity * meal.price
          order_item.save!

          order.total += requested_quantity * meal.price
          order.quantity += requested_quantity
          order.save!
        else
          # Create new ordered item for existing order
          order_item = OrderItem.create(order_id: order.id,
                                meal_id: requested_meal,
                                quantity: requested_quantity,
                                total_price: meal.price * requested_quantity)
        end
      else
        # Create a NEW order with ordered item
        order = Order.create( user_id: current_user.id,
                              cart_id: cart.id,
                              guid: SecureRandom.hex(10),
                              quantity: 0,
                              total: 0)
        order_item = OrderItem.create(order_id: order.id,
                                      meal_id: requested_meal,
                                      quantity: requested_quantity,
                                      total_price: meal.price * requested_quantity || 0)

      end
      if params[:quantity].present?
        order.total += requested_quantity * meal.price
        order.quantity = order.order_items.pluck(:quantity).sum
        order.save!
      end
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
