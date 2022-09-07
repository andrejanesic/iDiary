class FoodComplex < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, length: { maximum: 120 }, uniqueness: true
  validates :description, length: { maximum: 1000 }
end
