class Follow < ApplicationRecord
  belongs_to :user
  belongs_to :friend, :foreign_key => :friend_id, class_name: 'User'

  validates :user_id, presence: true
  validates :friend_id, presence: true

  def self.user_friends(current_user)
    require "pry";binding.pry
    where("host_id = ?", current_user.id)
    # Follow.joins("JOIN user ON follow.followed_id = user.id").select('users.email').where("host_id = ?", current_user.id).group('users.email')
  end
end
