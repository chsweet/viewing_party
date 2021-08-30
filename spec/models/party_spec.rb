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

  before :each do
    @user_1 = create(:user)
    @user_2 = create(:user)
    @user_3 = create(:user)
    @user_4 = create(:user)
    @user_5 = create(:user)

    @followed_1 = Follow.create!(user_id: @user_1.id, friend_id: @user_2.id)
    @followed_2 = Follow.create!(user_id: @user_1.id, friend_id: @user_4.id)
    @followed_3 = Follow.create!(user_id: @user_1.id, friend_id: @user_5.id)

    @party_1 = create(:party, user_id: @user_1.id, date_time: "2019-01-04 05:06:00 -0700")
  end
  describe 'instance variables' do
    describe '#date_format' do
      it 'returns the date_time formated' do
        expect(@party_1.date_format).to eq("January 04, 2019 12:06 pm")
      end
    end
  end
end
