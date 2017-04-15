class RemoveQuantityColumnFromCart < ActiveRecord::Migration[5.0]
  def change
    remove_column :carts, :quantity
    remove_column :orders, :meal_id
  end
end
