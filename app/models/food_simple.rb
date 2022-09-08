class FoodSimple < ApplicationRecord
  belongs_to :user
  #TODO add must have amount and kcal, protein, etc!
  validates :name, presence: true, length: { maximum: 120 }, uniqueness: true
  validates :description, length: { maximum: 1000 }
end
