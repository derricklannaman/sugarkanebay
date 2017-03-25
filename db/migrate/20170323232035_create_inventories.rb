class CreateInventories < ActiveRecord::Migration[5.0]
  def change
    create_table :inventories do |t|
      t.integer :order_item_id
      t.integer :minimum_level

      t.timestamps
    end
    add_index :inventories, :order_item_id
  end
end
