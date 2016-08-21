class AddIndexProfileImageToDestinations < ActiveRecord::Migration[5.0]
  def change
    add_column :destinations, :index_image, :string
  end
end
