require 'rails_helper'

RSpec.describe Party do
  describe 'relationships' do
    it {should belong_to :user}
    it {should have_many :attendees}
  end

  describe 'validations' do
    it {should validate_presence_of :movie}
    it {should validate_presence_of :user_id}
    it {should validate_presence_of :date_time}
    it {should validate_presence_of :duration}
  end
end
