class CreateInventoryProcessors < ActiveRecord::Migration[5.0]
  def change
    create_table :inventory_processors do |t|

      t.timestamps
    end
  end
end
