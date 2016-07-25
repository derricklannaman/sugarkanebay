class CreateCarts < ActiveRecord::Migration[5.0]
  def change
    create_table :carts do |t|
      t.references :user, foreign_key: true
      t.string :item
      t.decimal :price
      t.integer :quantity
      t.decimal :total

      t.timestamps
    end
  end
end
