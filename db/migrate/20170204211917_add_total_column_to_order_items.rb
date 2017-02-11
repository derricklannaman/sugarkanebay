class AddTotalColumnToOrderItems < ActiveRecord::Migration[5.0]
  def change
    add_column :order_items, :total_price, :decimal, precision: 5, scale: 2
  end
end
