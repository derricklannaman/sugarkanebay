class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  belongs_to :user
  belongs_to :meal
end
