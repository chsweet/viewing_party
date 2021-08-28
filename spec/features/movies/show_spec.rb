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
    expect(page).to have_content('Runtime: 2 hr 19 min')
    expect(page).to have_content('Genre(s): Drama')
    expect(page).to have_content("A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy. Their concept catches on, with underground \"fight clubs\" forming in every town, until an eccentric gets in the way and ignites an out-of-control spiral toward oblivion.")
  end

  it 'displays first ten movie actors with role', :vcr do
    visit movie_path(550)

    expect(page).to have_content('Edward Norton as The Narrator')
    expect(page).to have_content('Brad Pitt as Tyler Durden')
    expect(page).to have_content('Helena Bonham Carter as Marla Singer')
    expect(page).to have_content("Meat Loaf as Robert \"Bob\" Paulson")
    expect(page).to have_content('Jared Leto as Angel Face')
    expect(page).to_not have_content('Stuart Blumberg as Car Salesman')

    expect(page).to have_css(".actor", count: 10)
  end

  it 'displays movie review count and all review authors and content', :vcr do
    visit movie_path(550)

    expect(page).to have_content('7 Reviews')
    expect(page).to have_content('Author: Goddard')
    # expect(page).to have_content("Pretty awesome movie.  It shows what one crazy person can convince other crazy people to do.  Everyone needs something to believe in.  I recommend Jesus Christ, but they want Tyler Durden.")
    expect(page).to have_content('katch22')
    # expect(page).to have_content("Madness unbounded.  Don't try to make sense of insanity, just ride a wild ride.")
  end
end
