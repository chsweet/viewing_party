require 'rails_helper'

RSpec.describe User do
  describe 'relationships' do
    it {should have_many :parties}
    it {should have_many :attendees}

    it {should have_many :host_follows}
    it {should have_many(:hosts).through(:host_follows)}

    it {should have_many :followed_follows}
    it {should have_many(:followeds).through(:followed_follows)}
  end

  describe 'validations' do
    it {should validate_presence_of(:email)}
    it {should validate_uniqueness_of(:email)}
    it {should validate_presence_of(:password)}
  end
end
