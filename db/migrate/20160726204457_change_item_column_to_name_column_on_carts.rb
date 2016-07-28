class ChangeItemColumnToNameColumnOnCarts < ActiveRecord::Migration[5.0]
  def change
    rename_column :carts, :item, :owner_name
  end
end
