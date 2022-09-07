class BodyEntry < ApplicationRecord
  belongs_to :diary
  validates :height, allow_nil: true, numericality: { greater_than: 0, less_than_or_equal_to: 300 }
  validates :weight, allow_nil: true, numericality: { greater_than: 0, less_than_or_equal_to: 300 }
  validates :muscle_mass, allow_nil: true, numericality: { greater_than: 0, less_than_or_equal_to: 300 }
  validates :fat_mass, allow_nil: true, numericality: { greater_than: 0, less_than_or_equal_to: 300 }
  validates :note, allow_nil: true, length: { maximum: 500 }
  validates :timestamp, presence: true
end
