require 'rails_helper'

RSpec.describe 'user dashboard/index page' do
  before :each do
    @user_1 = create(:user)
    @user_2 = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)

    visit dashboard_path
  end

  it 'displays user specific welcome message' do
    expect(page).to have_content("Welcome #{@user_1.email}!")
  end

  it 'displays button to Discover Moives page' do
    expect(page).to have_button("Discover Movies")

    ###click_button path to Discover page
  end

  xit 'message shows if no friends have been added in friend section' do
    within("#friends") do
      expect(page).to have_content("You currently have no friends.")
    end
  end

  xit 'has friend section with a text field to enter a valid email and add a friends' do
    within("#friends") do
      fill_in "Friend's E-mail", with: @user_2.email

      expect(page).to have_content("#{@user_2.email}")
    end
  end

  xit 'give error when invalid email is entered in friend section text field' do
    within("#friends") do
      fill_in "Friend's E-mail", with: 'fail-test@email.com'

      expect(page).to have_content("I'm sorry your friend cannot be found.")
    end
  end
end
