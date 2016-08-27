class CreateDiscoveryContents < ActiveRecord::Migration[5.0]
  def change
    create_table :discovery_contents do |t|
      t.references :destination, foreign_key: true
      t.string :title
      t.string :thumbnail
      t.text :description
      t.string :immersive_type

      t.timestamps
    end
  end
end
