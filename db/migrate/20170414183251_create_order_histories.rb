class CreateOrderHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :order_histories do |t|
      t.references :user, foreign_key: true
      t.decimal :total
      t.integer :quantity
      t.string :guid
      t.date :order_shipped_date

      t.timestamps
    end
  end
end
