class AdminController < ApplicationController
  def dashboard
    orders = Order.where("created_at >= ?", Time.zone.now.beginning_of_day).where(order_status: 'pending-shipping')
    @todays_orders = orders.count
    @todays_sales = orders.pluck(:total).sum
    @shipped_orders = Order.where("updated_at >= ?", Time.zone.now.beginning_of_day).where(order_status: 'shipped').count
    @orders_past_7days = Order.where("created_at >= ?", 7.days.ago ).count

    top_sellers_past_30_days = Order.where(order_status: 'shipped').where("updated_at >= ?", 30.days.ago)
    meals = []
    top_sellers_past_30_days.each do |item|
      meals << [item.order_items, item.quantity]
    end

    counts = Hash.new(0)

    meals.each do |meal|
      if meal.first == "Jerk Pork"
          counts["Jerk Pork"] += meals.first.last
        elsif meal.first == "Jerk Chicken"
          counts["Jerk Chicken"] += meals.first.last
        elsif meal.first == "Curry Goat"
          counts["Curry Goat"] += meals.first.last
        elsif meal.first == "Ox Tail"
          counts["Ox Tail"] += meals.first.last
        elsif meal.first == "Curry Chicken"
          counts["Curry Chicken"] += meals.first.last
      end
    end

    @top_sellers_past_30_days = counts.sort_by { |key, value| value }.reverse.to_h
    # binding.pry

    # @counts = Hash.new(0)

    # top_sellers = meals.sum

    # top_sellers.each do |item|
    #   @counts[item] += ite

    # end
    #   carts.each do |cart|
    #   item_list = cart.orders.pluck(:order_items)
    #   item_list.each do |order|
    #     @counts[order] += 1
    #   end
    # end

  end

  def todays_orders
    @orders = Order.where(order_status: ['pending-shipping'] )

    @carts = []
    @orders_per_cart = @orders.group_by { |user| user.cart_id }.to_a
    @orders_per_cart.each do |cart|
      @carts << Cart.find(cart.first)
    end
  end

  def pull_list
    orders = Order.where(order_status: ['pending-shipping'] )

    carts = []
    orders_per_cart = orders.group_by { |user| user.cart_id }.to_a
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
    @shipped_orders = Order.where("updated_at >= ?", Time.zone.now.beginning_of_day).where(order_status: 'shipped')
  end

end