class User < ApplicationRecord
  has_many :host_follows, foreign_key: :host_id, class_name: 'Follow'
  has_many :hosts, through: :host_follows

  has_many :followed_follows, foreign_key: :followed_id, class_name: 'Follow'
  has_many :followeds, through: :followed_follows

  has_many :parties
  has_many :attendees
end
