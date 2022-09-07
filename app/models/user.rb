class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :diaries, dependent: :destroy
  has_many :diary_shares, dependent: :destroy
  has_many :goals, dependent: :destroy
  has_many :food_simples
  has_many :food_complexes

  enum role: %i[user admin]
end
