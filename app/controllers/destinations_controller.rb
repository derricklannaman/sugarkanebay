class DestinationsController < ApplicationController

  before_action :find_destination, except: :index

  def index
    @destinations = Destination.all
  end

  def discovery
  end

  def music
  end

  def points_of_interest
  end

  def culture
  end

  def foods
  end

  def art
  end

  def political
  end

  def geography
  end

  private

    def find_destination
      @destination = Destination.find(params[:id])
    end

end
