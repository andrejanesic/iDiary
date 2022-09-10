class Diary < ApplicationRecord
  belongs_to :user
  has_many :body_entries, dependent: :destroy
  has_many :intake_entries, dependent: :destroy
  has_many :exercise_entries, dependent: :destroy
  has_many :note_entries, dependent: :destroy
  has_many :diary_shares, dependent: :destroy
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { scope: :user_id }
end
