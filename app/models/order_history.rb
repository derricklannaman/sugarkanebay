# order_histories
class OrderHistory < ApplicationRecord
  belongs_to :user
  has_many :ordered_item_histories
end
