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

  it 'displays the movie title', :vcr do
    visit new_party_path(params: {movie_id: 550})

    expect(page).to have_content('Movie Title: Fight Club')
  end

  it 'new viewing party form defaults duration to movie runtime', :vcr do
    visit new_party_path(params: {movie_id: 550})

    find_field(:duration, with: 139).value
  end

  it 'it displays checkbox to invite current user friends', :vcr do
    visit new_party_path(params: {movie_id: 550})

    expect(page).to have_content(@user_2.email)
    expect(page).to_not have_content(@user_3.email)
    expect(page).to have_content(@user_4.email)
    expect(page).to have_content(@user_5.email)
  end

  it 'can create a new party and redirect_to current_user dashboard', :vcr do
    visit new_party_path(params: {movie_id: 550})

    expect(page).to have_content('Viewing Party Details')

    fill_in :duration, with: 180
    select('2020', from: :party_date_time_1i)
    select('November', from: :party_date_time_2i)
    select('5', from: :party_date_time_3i)
    select('07 PM', from: :party_date_time_4i)
    select('21', from: :party_date_time_5i)
    check("#{@user_2.email}")
    check("#{@user_5.email}")

    click_on('Create Party')

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content('Fight Club')
  end
end
