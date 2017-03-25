class CreateMealInventories < ActiveRecord::Migration[5.0]
  def change
    create_table :meal_inventories do |t|
      t.references :meal, foreign_key: true
      t.references :inventory, foreign_key: true

      t.timestamps
    end
  end
end
