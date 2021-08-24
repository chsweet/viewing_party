class Party < ApplicationRecord
  belongs_to :user
  has_many :attendees
end
