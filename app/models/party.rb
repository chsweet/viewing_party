class Party < ApplicationRecord
  belongs_to :user
  has_many :attendees

  validates :movie, presence: true
  validates :user_id, presence: true
  validates :date, presence: true
  validates :start_time, presence: true
  validates :duration, presence: true
end
