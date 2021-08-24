require 'rails_helper'

RSpec.describe Attendee do
  describe 'relationships' do
    it {should belong_to :party}
    it {should belong_to :user}
  end

  describe 'validations' do
    it {should validate_presence_of :party_id}
    it {should validate_presence_of :user_id}
  end
end
