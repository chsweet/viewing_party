require 'rails_helper'

RSpec.describe 'user dashboard/index page' do
  before :each do
    @user_1 = create(:user)
    @user_2 = create(:user)
    @user_3 = create(:user)

    visit dashboard_path(@user_1)
  end

  it 'displays user specific welcome message' do
    expect(page).to have_content("Welcome #{@user_1.email}!")
  end

  it 'displays button to Discover Moives page' do

  end

  it 'message shows if no friends have been added in friend section' do
    within("#friends") do
      expect(page).to have_content("You currently have no friends.")
    end
  end

  it 'has friend section with a text field to enter a valid email and add a friends' do
    within("#friends") do
      fill_in "Friend's E-mail" with: @user_2.email


    end
  end

  it 'give error when invalid email is entered in friend section text field' do
    within("#friends") do
      fill_in "Friend's E-mail" with: 'fail-test@email.com'

      expect(page).to have_content("")
    end
  end

end
