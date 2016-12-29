class AddThumbnailAndStandardImageToMeals < ActiveRecord::Migration[5.0]
  def change
    add_column :meals, :thumbnail_image, :string
    add_column :meals, :standard_image, :string
  end
end
