class Meal < ApplicationRecord
  has_many :inventories, through: :meal_inventories
  has_many :meal_inventories
  belongs_to :destination
  has_many :orders
  has_many :users, through: :orders
  has_many :order_items
end
