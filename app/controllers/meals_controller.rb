class MealsController < ApplicationController
  def index
  end

  def show
    @meal = Meal.find(params[:id])
    if current_user.blank? ||
      current_user.orders.where(meal_id: @meal.id).first.blank? ||
      current_user.orders.where(meal_id: @meal.id).where(order_status: 'active').blank?
      @meal_count = 0
    else
      @meal_count = current_user.orders.where(meal_id: @meal.id).where(order_status: 'active').first.quantity
    end
  end
end
