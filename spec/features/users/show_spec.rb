require 'rails_helper'

RSpec.describe 'user dashboard/index page' do
  before :each do
    @user_1 = create(:user)
    @user_2 = create(:user)
    @user_3 = create(:user)
    @user_4 = create(:user)
    @user_5 = create(:user)

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

  describe 'friends section' do
    it 'has friend section with a text field to enter a valid email and add a friends' do
      within("#friends") do
        fill_in :follow_email, with: @user_2.email
        click_button 'Add Friend'
      end
      @user_1.user_friends.reload

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)

      visit dashboard_path

      expect(page).to have_content(@user_2.email)
    end

    it 'give error when invalid email is entered in friend section text field' do
      within("#friends") do
        fill_in :follow_email, with: 'fail-test@email.com'
        click_button 'Add Friend'
      end
      ### do we want this message in the friend section??
      expect(page).to have_content("I'm sorry your friend cannot be found.")
    end

    it 'message shows if no friends have been added in friend section' do
      within("#friends") do
        expect(page).to have_content("You currently have no friends.")
      end
    end
  end

  describe 'viewing parties section' do
    before :each do
      @followed_1 = Follow.create!(user_id: @user_1.id, friend_id: @user_2.id)
      @followed_2 = Follow.create!(user_id: @user_1.id, friend_id: @user_4.id)
      @followed_3 = Follow.create!(user_id: @user_1.id, friend_id: @user_5.id)

      @party_1 = create(:party, user_id: @user_1.id)

      @attendee_1 = create(:attendee, user_id: @user_2.id, party_id: @party_1.id)
      @attendee_2 = create(:attendee, user_id: @user_4.id, party_id: @party_1.id)
      @attendee_3 = create(:attendee, user_id: @user_5.id, party_id: @party_1.id)
    end

    xit 'link to movie show page for the viewing party current user created' do
      within("#host_parties-#{@party_1.id}") do
        expect(page).to have_link(@party_1.movie)

        click_link "#{@party_1.movie}"

        expect(current_path).to eq(movie_path(@movie_1))
      end
    end

    xit 'displays the date & time of event that current user created' do
      within("#host_parties-#{@party_1.id}") do
        expect(page).to have_content(@party_1.date_time)
      end
    end

    xit 'displays current user is hosting the party' do
      within("#host_parties-#{@party_1.id}") do
        expect(page).to have_content("Host: #{current_user.email}")
      end
    end

    xit 'displays all friends invited to viewing party current user created' do
      within("#host_parties-#{@party_1.id}") do
        expect(page).to have_content(@user_2.email)
        expect(page).to_not have_content(@user_3.email)
        expect(page).to have_content(@user_4.email)
        expect(page).to have_content(@user_5.email)
      end
    end

    xit 'dispays viewing parties current user was invited to and all attributes' do
      within("#viewing_parties-#{@party_2.id}") do

      end
    end
  end
end
