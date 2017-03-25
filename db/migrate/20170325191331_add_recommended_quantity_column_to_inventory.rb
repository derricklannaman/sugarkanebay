class AddRecommendedQuantityColumnToInventory < ActiveRecord::Migration[5.0]
  def change
    add_column :inventories, :recommended_quantity, :integer, default: 0
    add_column :inventories, :name, :string
  end
end
