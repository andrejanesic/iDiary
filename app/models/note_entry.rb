class NoteEntry < ApplicationRecord
  belongs_to :diary
  validates :note, allow_nil: true, length: { maximum: 1000 }
  validates :timestamp, presence: true
end
