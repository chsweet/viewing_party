class Attendee < ApplicationRecord
  belongs_to :party
  belongs_to :user

  validates :party_id, presence: true
  validates :user_id, presence: true

##should this be in the User model?? able to user it in for attendee list and the party??
  # def user_email
  #   require "pry";binding.pry
  #   User.find(self.user_id).email
  # end
end
