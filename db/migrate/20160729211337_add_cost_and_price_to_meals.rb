class AddCostAndPriceToMeals < ActiveRecord::Migration[5.0]
  def change
    add_column :meals, :cost, :decimal, precision: 5, scale: 2
    add_column :meals, :price, :decimal, precision: 5, scale: 2
  end
end
