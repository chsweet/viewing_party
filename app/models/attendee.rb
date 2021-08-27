class Attendee < ApplicationRecord
  belongs_to :party
  belongs_to :user

  validates :party_id, presence: true
  validates :user_id, presence: true

  def attendee_email
    User.find(self.user_id).email
  end
end
