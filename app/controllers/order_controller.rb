class OrderController < ApplicationController
  before_action :manage_entry_point_cookies, only: :create
  before_action :authenticate_user!, only: :create

  def new
  end

  def create
    if current_user.cart.present?
      cart = current_user.cart
      meal = Meal.find(params[:meal_id])
      requested_quantity = params[:quantity].to_i
      requested_meal = params[:meal_id].to_i

      if current_user.orders.where(order_status: 'pending-payment').present? #def current_orders_exist?
        # binding.pry
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
      flash[:notice] = "#{params[:meal_name]} has been added to your cart"
      redirect_to shop_path
    else
      flash[:notice] = "Please sign up or sign in first."
      redirect_to new_user_registration_path(redirect_to: request.path)
    end
  end

  def add_item
    order_item = OrderItem.find(params[:order_id])
    meal = Meal.find(order_item.meal_id)
    current_orders = current_user.orders.first #def current_orders_exist?

    count = order_item.quantity += 1
    order_item.total_price = meal.price * count
    order_item.save!
    # whole order
    current_orders.total = order_item.order.order_items.sum(:total_price)
    current_orders.quantity = order_item.order.order_items.sum(:quantity)
    current_orders.save
    flash[:notice] = "Another #{meal.name} has been added from your cart"
    redirect_back fallback_location: cart_path(current_user.cart)
  end

  def subtract_item
    order_item = OrderItem.find(params[:order_id])
    meal = Meal.find(order_item.meal_id)
    current_orders = current_user.orders.first
    if order_item.quantity == 1
       # order item
      order_item.destroy
      # whole order
      current_orders.total = order_item.order.order_items.sum(:total_price)
      current_orders.quantity = order_item.order.order_items.sum(:quantity)
      current_orders.save
    else
      # order item
      count = order_item.quantity -= 1
      order_item.total_price = meal.price * count
      order_item.save!
      # whole order
      current_orders.total = order_item.order.order_items.sum(:total_price)
      current_orders.quantity = order_item.order.order_items.sum(:quantity)
      current_orders.save
      flash[:notice] = "#{meal.name} has been removed from your cart"
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

  def manage_entry_point_cookies
    return if current_user.present? && cookies[:entry_point_url].blank?
    if current_user.present? && cookies[:entry_point_url].present?
      cookies.delete :entry_point_url
      cookies.delete :entry_point_quantity
    else
      cookies[:entry_point_url] = ''
      cookies[:entry_point_url] = request.referer
      cookies[:entry_point_quantity] = params[:quantity]
    end
  end

end
