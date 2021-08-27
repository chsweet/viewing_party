require 'rails_helper'

RSpec.describe User do
  describe 'relationships' do
    it {should have_many :parties}
    it {should have_many :attendees}

    it {should have_many :follows}
    it {should have_many(:friends).through(:follows)}
  end

  describe 'validations' do
    it {should validate_presence_of(:email)}
    it {should validate_uniqueness_of(:email)}
    it {should validate_presence_of(:password)}
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
    @party_2 = create(:party, user_id: @user_4.id)
    @party_3 = create(:party, user_id: @user_5.id)

    @attendee_1 = create(:attendee, user_id: @user_2.id, party_id: @party_1.id)
    @attendee_2 = create(:attendee, user_id: @user_4.id, party_id: @party_1.id)
    @attendee_3 = create(:attendee, user_id: @user_5.id, party_id: @party_1.id)
    @attendee_4 = create(:attendee, user_id: @user_1.id, party_id: @party_2.id)
    @attendee_5 = create(:attendee, user_id: @user_2.id, party_id: @party_2.id)
    @attendee_6 = create(:attendee, user_id: @user_1.id, party_id: @party_3.id)
    @attendee_7 = create(:attendee, user_id: @user_3.id, party_id: @party_3.id)
  end

  describe 'instance methods' do
    describe '#user_friends' do
      it 'returns all the current user friends followed' do
        actual = @user_1.user_friends.map do |user|
          user.email
        end

        expect(@user_1.user_friends.length).to eq(3)
        expect(@user_1.user_friends).to_not include(@user_3)
        expect(actual).to match([@user_2.email, @user_4.email, @user_5.email])
      end
    end

    describe '#invited_parties' do
      it 'returns all parties user was invited to' do
        expect(@user_1.invited_parties).to match([@party_2, @party_3])
        expect(@user_1.invited_parties).to_not include(@party_1)
      end
    end
  end
end
