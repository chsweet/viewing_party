class Follow < ApplicationRecord
  belongs_to :host, class_name: 'User'
  belongs_to :followed, class_name: 'User'

  validates :host_id, presence: true
  validates :followed_id, presence: true

  def self.user_friends(current_user)
    require "pry";binding.pry
    where("host_id = ?", current_user.id)
    # Follow.joins("JOIN user ON follow.followed_id = user.id").select('users.email').where("host_id = ?", current_user.id).group('users.email')
  end
end
