class AdminController < ApplicationController
  def dashboard
    orders = Order.where("created_at >= ?", Time.zone.now.beginning_of_day).where(order_status: 'pending-shipping')
    @todays_orders = orders.count
    @todays_sales = orders.pluck(:total).sum
    @shipped_orders = Order.where("created_at >= ?", Time.zone.now.beginning_of_day).where(order_status: 'shipped').count
    @orders_past_7days = Order.where("created_at >= ?", 7.days.ago ).count
  end

  def todays_orders
    @orders = Order.where("created_at >= ?", Time.zone.now.beginning_of_day).where(order_status: ['pending-shipping', 'shipped'] )
  end

  def todays_shipped_orders
    @shipped_orders = Order.where("created_at >= ?", Time.zone.now.beginning_of_day).where(order_status: 'pending-shipping')
  end

end