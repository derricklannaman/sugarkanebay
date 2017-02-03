class AddOrdershippedColumnToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :order_shipped_date, :date
  end
end
