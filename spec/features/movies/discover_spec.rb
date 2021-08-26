require 'rails_helper'

RSpec.describe 'Discover' do
  describe 'authenticated user' do
    before(:each) do
      @user1 = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)

      visit('/discover')
    end

    it 'can find top rated movies' do
      expect(page).to have_content("Welcome #{@user1.email}")
      click_on('Find Top Rated Movies')

      expect(current_path).to eq(movies_path)
    end

    it 'can search by movie title' do
      fill_in(:search, with:('Titanic'))
      click_on('Find Movies')

      expect(current_path).to eq(movies_path)
    end
  end

  describe 'unauthenticated user' do
    it 'redirects to root path' do
      expect(page).to have_content("Uh Oh, Can't go there! Try logging in or registering as a new user.")
      expect(current_path).to eq(root_path)
    end
  end
end
