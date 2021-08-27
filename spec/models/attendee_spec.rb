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

  before :each do
    @user_1 = create(:user)
    @user_2 = create(:user)
    @user_3 = create(:user)
    @user_4 = create(:user)
    @user_5 = create(:user)

    @followed_1 = Follow.create!(user_id: @user_1.id, friend_id: @user_2.id)
    @followed_2 = Follow.create!(user_id: @user_1.id, friend_id: @user_4.id)
    @followed_3 = Follow.create!(user_id: @user_1.id, friend_id: @user_5.id)
    @followed_4 = Follow.create!(user_id: @user_2.id, friend_id: @user_3.id)
    @followed_5 = Follow.create!(user_id: @user_2.id, friend_id: @user_4.id)

    @party_1 = create(:party, user_id: @user_1.id)

    @attendee_1 = create(:attendee, user_id: @user_2.id, party_id: @party_1.id)
    @attendee_2 = create(:attendee, user_id: @user_4.id, party_id: @party_1.id)
    @attendee_3 = create(:attendee, user_id: @user_5.id, party_id: @party_1.id)
  end

  describe 'instance methods' do
    describe '#attendee_email' do
      it 'returns the attendees email' do
        expect(@party_1.user_email).to eq(@user_1.email)
        expect(@attendee_1.user_email).to eq(@user_2.email)
        expect(@attendee_2.user_email).to eq(@user_4.email)
        expect(@attendee_3.user_email).to eq(@user_5.email)
      end
    end
  end
end
