class AdminController < ApplicationController
  def dashboard
    @total_number_active_orders = Order.where(order_status: "active").pluck(:quantity).sum
    @total_overall_orders = Order.all.pluck(:quantity).sum

    @orders_past_7days = Order.where("created_at >= ?", 7.days.ago ).count
    @timezonetest = Time.now.in_time_zone("Central Time (US & Canada)")
    @todays_orders = Order.where("created_at >= ?", Time.zone.now.beginning_of_day).count


    # o.strftime("%I:%M%p")
  end
end