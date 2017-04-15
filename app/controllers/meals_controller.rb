class MealsController < ApplicationController
  def index
  end

  def show
    @meal = Meal.find(params[:id])
    if current_user.blank? #||
      # current_user.orders.where(meal_id: @meal.id).first.blank? ||
      # current_user.orders.where(meal_id: @meal.id).where(order_status: 'pending-payment').blank?
      @meal_count = 0
    else
      # binding.pry
      # if current_user.orders.where(order_status: 'pending-payment').present?
        # @cart_total = current_user.orders.where(order_status: 'pending-payment')
                                  # .first.total
      # else

      # end


      # @meal_count = current_user.orders.where(meal_id: @meal.id).where(order_status: 'pending-payment').first.quantity
      @meal_count = number_of_items_in_cart || 0
      # binding.pry
    end
  end
end
