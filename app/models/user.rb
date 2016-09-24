class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  has_one :cart, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :meals, through: :orders

  after_create :create_cart, :auto_add_attributes

  def create_cart
    Cart.create!(user_id: self.id, owner_name: self.firstname.capitalize, total: 0, quantity: 0)
  end

  def auto_add_attributes
    self.firstname = self.firstname.capitalize
    self.country = "USA"
    self.save!
  end

end
