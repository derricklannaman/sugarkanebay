class Inventory < ApplicationRecord
  has_many :meals, through: :meal_inventories
  has_many :meal_inventories

  def self.reduce_current_quantity(orders)
    orders.each do |order|
      inventory_item = self.find_by_meal_id(order.meal_id)
      inventory_item.current_quantity -= order.quantity
      inventory_item.save!
    end
  end

end

