class Follow < ApplicationRecord
  belongs_to :host, class_name: 'User'
  belongs_to :followed, class_name: 'User'

  validates :host_id, presence: true
  validates :followed_id, presence: true

  def self.user_friends(current_user)
    where("host_id = ?", current_user.id)
  end
end
