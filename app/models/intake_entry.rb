class IntakeEntry < ApplicationRecord
  belongs_to :diary
  validates :note, allow_nil: true, length: { maximum: 500 }
  validates :timestamp, presence: true
end
