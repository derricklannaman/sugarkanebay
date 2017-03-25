class Inventory < ApplicationRecord
  has_many :meals, through: :meal_inventories
  has_many :meal_inventories
end
