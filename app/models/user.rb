class User < ApplicationRecord
  has_many :host_follows, foreign_key: :host_id, class_name: 'Follow', dependent: :destroy
  has_many :hosts, through: :host_follows

  has_many :followed_follows, foreign_key: :followed_id, class_name: 'Follow', dependent: :destroy
  has_many :followeds, through: :followed_follows

  has_many :parties, dependent: :destroy
  has_many :attendees, dependent: :destroy

  validates :email, presence: true, uniqueness: true

  has_secure_password
end
