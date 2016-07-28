class CartController < ApplicationController
  before_action :authenticate_user!
  before_action :check_cart_exist, only: :show

  def show
    @orders = current_user.cart.orders if current_user.cart.present?
  end

  def checkout
    @orders = current_user.cart.orders
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
