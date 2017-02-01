class AddDescriptionToMeals < ActiveRecord::Migration[5.0]
  def change
    add_column :meals, :description_details, :text
  end
end
