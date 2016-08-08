class CartController < ApplicationController
  before_action :authenticate_user!
  before_action :check_cart_exist, only: :show

  def show
    @orders = current_user.cart.orders.where(order_status: 'active').sort if current_user.cart.present?
    cart_total
  end

  def checkout
    @orders = current_user.cart.orders.where(order_status: 'active').sort
    cart_total
  end

  def account
    if current_user.cart.present?
      @orders = current_user.cart.orders.where(order_status: 'active').sort
      previous_orders = current_user.cart.orders.where(order_status: 'inactive').order(created_at: :desc)
      @prev_orders = previous_orders.group_by { |order| order.created_at.to_date }.to_a
    end
  end

  def cart_total
    unless current_user.cart.blank?
      cart_total = current_user.cart.orders.where(order_status: 'active').pluck(:total).sum
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
