class Meal < ApplicationRecord
  belongs_to :destination
  has_many :orders
  has_many :users, through: :orders
  has_many :order_items
end
