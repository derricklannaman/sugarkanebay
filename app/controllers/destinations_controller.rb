class DestinationsController < ApplicationController

  # before_action :find_destination, except: :index
  # before_action :immersive_layout, except: [:index]

  def index
    # @destinations = Destination.all
  end

  # def discovery
  #   binding.pry
  #   @discovery_contents = @destination.discovery_contents
  #   binding.pry
  # end

  def music_immersive
  end

  def points_of_interest_immersive
  end

  def culture_immersive
  end

  def foods_immersive
  end

  def art_immersive
  end

  def political_immersive
  end

  def geography_immersive
  end

  private

    def immersive_layout
      @discovery_contents = @destination.discovery_contents
      render layout: "immersive"
    end

    def find_destination
      @destination = Destination.find(params[:id])
    end
end
