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

  it 'displays button to Discover Movies page', js: true do

    a = page.find('#hamburger')

    a.click
    click_on 'Discover Movies'

    expect(current_path).to eq(discover_path)
  end

  describe 'friends section' do
    it 'has friend section with a text field to enter a valid email and add a friends' do
      within("#friends") do
        fill_in :follow_email, with: @user_3.email
        click_button 'Add Friend'
      end
      @user_1.user_friends.reload

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)

      visit dashboard_path

      expect(page).to have_content(@user_3.email)
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
      @followed_4 = Follow.create!(user_id: @user_4.id, friend_id: @user_1.id)
      @followed_5 = Follow.create!(user_id: @user_4.id, friend_id: @user_2.id)
      @followed_6 = Follow.create!(user_id: @user_5.id, friend_id: @user_1.id)
      @followed_7 = Follow.create!(user_id: @user_5.id, friend_id: @user_3.id)

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

      @user_1.reload

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)

      visit dashboard_path
    end

    xit 'link to movie show page for the viewing party current user created', :vcr do
      #need to figure out the movie link and API call
      within("#host_parties-#{@party_1.id}") do
        expect(page).to have_link(@party_1.movie)

        click_link "#{@party_1.movie}"

        expect(current_path).to eq(movie_path(@party_1.movie_id))
      end
    end

    it 'displays the date & time of event that current user created' do
      within("#host_parties-#{@party_1.id}") do
        expect(page).to have_content(@party_1.date_format)
      end
    end

    it 'displays current user is hosting the party' do
      within("#host_parties-#{@party_1.id}") do
        expect(page).to have_content("Host: #{@user_1.email}")
      end
    end

    it 'displays all friends invited to viewing party current user created' do
      within("#host_parties-#{@party_1.id}") do
        expect(page).to have_content(@user_2.email)
        expect(page).to_not have_content(@user_3.email)
        expect(page).to have_content(@user_4.email)
        expect(page).to have_content(@user_5.email)
      end
    end

    xit 'dispays link to movie show page for viewing parties current user was invited to', :vcr do
      within("#invited_parties-#{@party_2.id}") do
        expect(page).to have_link(@party_2.movie)

        click_link "#{@party_2.movie}"

        expect(current_path).to eq(movie_path(@party_2.movie_id))
      end

      within("#invited_parties-#{@party_3.id}") do
        expect(page).to have_link(@party_3.movie)

        click_link "#{@party_3.movie}"

        expect(current_path).to eq(movie_path(@party_3.movie_id))
      end
    end

    it 'dispays the date & time of event for viewing parties current user was invited to' do
      within("#invited_parties-#{@party_2.id}") do
        expect(page).to have_content(@party_2.date_format)
      end

      within("#invited_parties-#{@party_3.id}") do
        expect(page).to have_content(@party_3.date_format)
      end
    end

    it 'dispays host of viewing parties current user was invited to' do
      within("#invited_parties-#{@party_2.id}") do
        expect(page).to have_content("Host: #{@user_4.email}")
      end

      within("#invited_parties-#{@party_3.id}") do
        expect(page).to have_content("Host: #{@user_5.email}")
      end
    end

    it 'dispays all attendees of viewing parties current user was invited to with current user in BOLD' do
      within("#invited_parties-#{@party_2.id}") do
        expect(page).to have_content(@user_1.email)
        expect(page).to have_content(@user_2.email)
      end

      within("#invited_parties-#{@party_3.id}") do
        expect(page).to have_content(@user_1.email)
        expect(page).to have_content(@user_3.email)
      end
    end
  end

  describe 'logout' do
    it 'can log user out and redirect to welcome', js: true do
      a = page.find('#hamburger')

      a.click
      
      click_on 'Log Out'

      expect(current_path).to eq(root_path)
      expect(page).to have_content('You have now logged out')
    end
  end
end
