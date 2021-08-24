require 'rails_helper'

RSpec.describe Follow do
  describe 'relationships' do
    it {should belong_to :host}
    it {should belong_to :followed}
  end

  describe 'validations' do
    it {should validate_presence_of :host_id}
    it {should validate_presence_of :followed_id}
  end
end
