class Party < ApplicationRecord
  belongs_to :user
  has_many :attendees, dependent: :destroy

  validates :movie, presence: true
  validates :movie_id, presence: true
  validates :user_id, presence: true
  validates :date_time, presence: true
  validates :duration, presence: true

  def date_format
    date_time.strftime("%B %d, %Y %I:%M %P")
  end
end
