class PagesController < ApplicationController
  # before_action :return_to_order_url, only: :shop

  def index
    # @destination = Destination.find(1)
    # @discovery_contents = @destination.discovery_contents.limit(4)
  end

  def shop
    destinations = Destination.all
    meals = destinations.map {|destination| destination.meals}.flatten
    @meal_group_left, @meal_group_right = meals.each_slice( (meals.size/2.0).round ).to_a
  end

  def how_it_works
  end

  def about
  end
end
