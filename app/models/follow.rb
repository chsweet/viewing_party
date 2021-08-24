class Follow < ApplicationRecord
  belongs_to :host, class_name: 'User'
  belongs_to :followed, class_name: 'User'

  validates :host_id, presence: true
  validates :followed_id, presence: true
end
