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
  end

  describe 'instance methods' do
    describe '#user_friends' do
      it 'returns all the current user friends followed' do
        actual = @user_1.user_friends.map do |user|
          user.email
        end

        expect(@user_1.user_friends.length).to eq(3)
        expect(@user_1.user_friends).to_not include(@user_3)
        expect(actual).to eq([@user_2.email, @user_4.email, @user_5.email])
      end
    end
  end
end
