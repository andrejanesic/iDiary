class Diary < ApplicationRecord
  belongs_to :user
  has_many :body_entries, dependent: :destroy
  validates :name, presence: true, length: { maximum: 50 }
end
