class Goal < ApplicationRecord
  belongs_to :user
  # TODO: add numericality validation
  # validates :calories, allow_nil: true
  # validates :fats, allow_nil: true
  # validates :carbs, allow_nil: true
  # validates :proteins, allow_nil: true
  validates :frequency, presence: true, acceptance: { accept: %w[daily weekly monthly quarterly yearly] }
end
