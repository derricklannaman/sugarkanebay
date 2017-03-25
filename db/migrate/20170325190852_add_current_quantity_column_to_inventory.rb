class AddCurrentQuantityColumnToInventory < ActiveRecord::Migration[5.0]
  def change
    add_column :inventories, :current_quantity, :integer, default: 0
  end
end
