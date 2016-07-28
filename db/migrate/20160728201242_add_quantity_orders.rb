class AddQuantityOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :quantity, :integer, default: 0
  end
end
