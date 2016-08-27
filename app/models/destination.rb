class Destination < ApplicationRecord
  has_many :meals
  has_many :discovery_contents
end
