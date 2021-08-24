class Attendee < ApplicationRecord
  belongs_to :party
  belongs_to :user

  validates :party_id, presence: true
  validates :user_id, presence: true
end
