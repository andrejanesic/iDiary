class DiaryShare < ApplicationRecord
  belongs_to :diary
  belongs_to :user
  validates :permission, presence: true, numericality: {
    greater_than_or_equal_to: DiariesHelper::PERMISSION_NOPERMISSION,
    less_than_or_equal_to: DiariesHelper::PERMISSION_OWNERSHIP
  }
end
