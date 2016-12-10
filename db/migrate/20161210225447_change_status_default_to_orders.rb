class ChangeStatusDefaultToOrders < ActiveRecord::Migration[5.0]
  def change
    change_column_default :orders, :order_status, "pending-payment"
  end
end
