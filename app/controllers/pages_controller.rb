class PagesController < ApplicationController

  def index
    @destination = Destination.find(1)
    @discovery_contents = @destination.discovery_contents.limit(4)
  end

  def shop
    destinations = Destination.all
    @meals = destinations.map {|destination| destination.meals}.flatten
  end

  def how_it_works
  end

  def about
  end
end
