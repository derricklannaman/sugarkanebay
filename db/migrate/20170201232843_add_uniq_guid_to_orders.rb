class AddUniqGuidToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :guid, :string
  end
end
