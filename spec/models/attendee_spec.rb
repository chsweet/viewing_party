require 'rails_helper'

RSpec.describe Attendee do
  describe 'relationships' do
    it {should belong_to :party}
    it {should belong_to :user}
  end
end
