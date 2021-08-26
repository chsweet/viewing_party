require 'rails_helper'

RSpec.describe Follow do
  describe 'relationships' do
    it {should belong_to :user}
    it {should belong_to :friend}
  end

  describe 'validations' do
    it {should validate_presence_of :user_id}
    it {should validate_presence_of :friend_id}
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

  describe 'class methods' do
    describe '::user_friends' do
      it 'returns all the current user friends followed' do
        actual = Follow.user_friends(@user_1).map do |user|
          user.email
        end

        expect(Follow.user_friends(@user_1).length).to eq(3)
        expect(Follow.user_friends(@user_1)).to_not include(@user_3)
        expect(actual).to eq([@user_2.email, @user_4.email, @user_5.email])
      end
    end
  end
end
