class AddDiscoveryImagesToDestinations < ActiveRecord::Migration[5.0]
  def change
    add_column :destinations, :food_discovery_thumbnail, :string
    add_column :destinations, :poi_discovery_thumbnail, :string
    add_column :destinations, :music_discovery_thumbnail, :string
    add_column :destinations, :geography_discovery_thumbnail, :string
    add_column :destinations, :culture_discovery_thumbnail, :string
    add_column :destinations, :art_discovery_thumbnail, :string
    add_column :destinations, :political_discovery_thumbnail, :string
    add_column :destinations, :shop_discovery_thumbnail, :string
  end
end
