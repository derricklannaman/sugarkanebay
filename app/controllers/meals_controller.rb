class MealsController < ApplicationController
  def index
  end

  def show
    @meal = Meal.find(params[:id])
  end
end
