class AddUseridToMeals < ActiveRecord::Migration[5.0]
  def change
    add_column :meals, :user_id, :integer
    add_index :meals, :user_id
  end
end
