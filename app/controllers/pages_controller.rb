class PagesController < ApplicationController

  def index
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
