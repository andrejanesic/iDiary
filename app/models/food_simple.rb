class FoodSimple < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, length: { maximum: 120 }, uniqueness: true
end
