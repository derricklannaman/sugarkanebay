class MealInventory < ApplicationRecord
  belongs_to :meal
  belongs_to :inventory
end
