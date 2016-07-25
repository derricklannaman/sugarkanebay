class AddOrderStatusToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :order_status, :string, :default => 'active'
  end
end
