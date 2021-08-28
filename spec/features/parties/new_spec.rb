require 'rails_helper'

RSpec.describe 'new viewing party page' do
  before :each do
    @user_1 = create(:user)
    @user_2 = create(:user)
    @user_3 = create(:user)
    @user_4 = create(:user)
    @user_5 = create(:user)

    @followed_1 = Follow.create!(user_id: @user_1.id, friend_id: @user_2.id)
    @followed_2 = Follow.create!(user_id: @user_1.id, friend_id: @user_4.id)
    @followed_3 = Follow.create!(user_id: @user_1.id, friend_id: @user_5.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
  end

  xit 'displays a link to create a viewing party for movie', :vcr do
    visit movie_path(550)

    click_button('Create Viewing Party for Movie')

    expect(current_path).to eq(new_party_path)
  end

  it 'displays the movie title', :vcr do
    visit new_party_path

    expect(page).to have_content('Movie Title Fight Club')
  end

  xit 'new viewing party form defaults duration to movie runtime', :vcr do
    visit new_party_path

    expect(page).to have_content('Duration of Party 139')
  end

  xit 'it displays checkbox to invite current user friends' do
    visit new_party_path

    expect(page).to have_content(@user_2.email)
    expect(page).to_not have_content(@user_3.email)
    expect(page).to have_content(@user_4.email)
    expect(page).to have_content(@user_5.email)
  end

  xit 'can create a new party and redirect_to current_user dashboard' do
    visit new_party_path

    expext(page).to have_content('Viewing Party Details')

    fill_in 'Duration of Party', with: 180
    fill_in 'Day', with: '12/20/20'
    fill_in 'Start Time', with: '1:00'
    check("#{@user_2.email}")
    check("#{@user_5.email}")

    click_on('Create Party')

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content('Fight Club')
  end
end
