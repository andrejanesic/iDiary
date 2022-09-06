class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :diaries, dependent: :destroy

  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :username, presence: true
  enum role: %i[user admin]
end
