class User < ApplicationRecord
  has_many :follows
  has_many :friends, through: :follows

  has_many :parties, dependent: :destroy
  has_many :attendees, dependent: :destroy

  validates :email, presence: true, uniqueness: true

  has_secure_password

  def user_friends
    friends
  end
end
