class ChangeTheModelAtTime1490468791 < ActiveRecord::Migration[5.0]
  def change
    add_column :inventories, :meal_id, :integer, null: false
  end
end
