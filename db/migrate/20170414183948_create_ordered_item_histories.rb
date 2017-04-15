class CreateOrderedItemHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :ordered_item_histories do |t|
      t.references :order_history, foreign_key: true
      t.integer :meal_id
      t.integer :quantity
      t.decimal :total_price

      t.timestamps
    end
  end
end
