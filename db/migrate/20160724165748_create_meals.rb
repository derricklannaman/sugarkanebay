class CreateMeals < ActiveRecord::Migration[5.0]
  def change
    create_table :meals do |t|
      t.string :name
      t.references :destination, foreign_key: true

      t.timestamps
    end
  end
end
