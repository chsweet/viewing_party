require 'rails_helper'

RSpec.describe 'movies show page' do
  before :each do
    @user_1 = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
  end

  it 'can show movie title, summary, vote average, runtime, genre', :vcr do
    visit movie_path(550)

    expect(page).to have_content("Fight Club")
    expect(page).to have_content('Vote Average: 8.4')
    #expect(page).to have_content('Runtime: 2 hr 19 min')
    #expect(page).to have_content('Genre(s): Drama')
    expect(page).to have_content("A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy. Their concept catches on, with underground \"fight clubs\" forming in every town, until an eccentric gets in the way and ignites an out-of-control spiral toward oblivion.")
  end
end
