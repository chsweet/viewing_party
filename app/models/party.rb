class Party < ApplicationRecord
  belongs_to :user
  has_many :attendees, dependent: :destroy

  validates :movie, presence: true
  validates :user_id, presence: true
  validates :date_time, presence: true
  validates :duration, presence: true
end
