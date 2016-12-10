class CreateOrderStatuses < ActiveRecord::Migration[5.0]
  def change
    create_table :order_statuses do |t|
      t.references :order, foreign_key: true
      t.references :user, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
