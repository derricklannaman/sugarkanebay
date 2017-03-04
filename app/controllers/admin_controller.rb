# admin
class AdminController < ApplicationController
  def dashboard
    orders = Order.where('created_at >= ?', Time.zone.now.beginning_of_day)
    @todays_orders = orders.count
    @todays_sales = orders.pluck(:total).sum
    @orders_shipped = Order.where('updated_at >= ?', Time.zone
                    .now.beginning_of_day).where(order_status: 'shipped').count
    @orders_past_7days = Order.where('order_shipped_date >= ?', 7.days.ago)
                              .count

    @today = Date.today.strftime('%m/%d/%Y')

    today = Date.today

    orders_shipped = Order.where(order_status: 'shipped')

    count_orders_this_weeks(today, orders_shipped)
    count_orders_this_month(today, orders_shipped)
    count_orders_this_year(today, orders_shipped)

    top_sellers_past_30_days = Order.where(order_status: 'shipped')
                                    .where('order_shipped_date >= ?',
                                           30.days.ago)
    meals = []
    top_sellers_past_30_days.each do |item|
      meals << [item.order_items, item.quantity]
    end

    counts = Hash.new(0)

    meals.each do |meal|
      if meal.first == 'Jerk Pork'
        counts['Jerk Pork'] += meal.last
      elsif meal.first == 'Jerk Chicken'
        counts['Jerk Chicken'] += meal.last
      elsif meal.first == 'Curry Goat'
        counts['Curry Goat'] += meal.last
      elsif meal.first == 'Ox Tail'
        counts['Ox Tail'] += meal.last
      elsif meal.first == 'Curry Chicken'
        counts['Curry Chicken'] += meal.last
      end
    end
    @top_sellers_past_30_days = counts.sort_by { |_key, value| value }
                                      .reverse.to_h
  end

  def todays_orders
    @orders = Order.where(order_status: ['pending-shipping'])
    @carts = []
    @orders_per_cart = @orders.group_by(&:cart_id).to_a
    @orders_per_cart.each do |cart|
      @carts << Cart.find(cart.first)
    end
  end

  def pull_list
    orders = Order.where(order_status: ['pending-shipping'])
    carts = []
    orders_per_cart = orders.group_by(&:cart_id).to_a
    orders_per_cart.each do |cart|
      carts << Cart.find(cart.first)
    end

    @counts = Hash.new(0)
    carts.each do |cart|
      item_list = cart.orders.pluck(:order_items)
      item_list.each do |order|
        @counts[order] += 1
      end
    end
  end

  def todays_shipped_orders
    @orders_shipped = Order.where('order_shipped_date >= ?', Time.zone.now
                           .beginning_of_day).where(order_status: 'shipped')
  end

  private

  def count_orders_this_weeks(today, orders)
    total_orders_this_week = orders.where('order_shipped_date >= ?',
                                          today.beginning_of_week)
    @sum_total_for_week = total_orders_this_week.map(&:total).sum
    @total_orders_this_week = total_orders_this_week.count
  end

  def count_orders_this_month(today, orders)
    total_orders_this_month = orders.where('order_shipped_date >= ?',
                                           today.beginning_of_month)
    @total_orders_this_month = total_orders_this_month.count
    @sum_total_for_month = total_orders_this_month.map(&:total).sum
  end

  def count_orders_this_year(today, orders)
    total_orders_this_year = orders.where('order_shipped_date >= ?',
                                          today.beginning_of_year)
    @total_orders_this_year = total_orders_this_year.count
    @sum_total_for_year = total_orders_this_year.map(&:total).sum
  end
end
