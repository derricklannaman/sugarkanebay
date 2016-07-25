class DestinationsController < ApplicationController
  def index
    @destinations = Destination.all
  end

  def discovery
    @destination = Destination.find(params[:id])
  end

end
