require 'rails_helper'

RSpec.describe 'Movies Index' do
  before(:each) do
    @user1 = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
  end

  describe 'top 40 movies' do
    it 'grabs top 40 movies from discover page', :vcr do
      visit '/discover'
      click_on('Find Top Rated Movies')

      expect(current_path).to eq(movies_path)

      expect(page).to have_css(".movie", count: 40)
      expect('The Suicide Squad').to appear_before('PAW Patrol: The Movie')
      expect("Free Guy").to appear_before("Sweet Girl")
    end

    it 'grabs top 40 movies from movies page', :vcr do
      visit movies_path

      expect(page).to have_css(".movie", count: 40)
      expect('The Suicide Squad').to appear_before('PAW Patrol: The Movie')
      expect("Free Guy").to appear_before("Sweet Girl")
    end
  end

  describe 'search' do
    before(:each) do
      @user1 = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
    end

    it 'grabs movies by title search from discover page', :vcr do
      visit '/discover'

      fill_in(:search, with:('Titanic'))
      click_on('Find Movies')

      expect(current_path).to eq(movies_path)

      expect(page).to have_css(".movie", count: 40)
      expect(page).to have_content('Titanic')
      expect(page).to have_content('Vote Average: 7.9')
    end

    it 'grabs movies by title search from movies page', :vcr do
      visit movies_path

      fill_in(:search, with:('Titanic'))
      click_on('Find Movies')

      expect(current_path).to eq(movies_path)

      expect(page).to have_css(".movie", count: 40)
      expect(page).to have_content('Titanic')
      expect(page).to have_content('Vote Average: 7.9')
    end

    it 'search is not case sensitive', :vcr do
      visit movies_path

      fill_in(:search, with:('TiTanIC'))
      click_on('Find Movies')

      expect(current_path).to eq(movies_path)
      expect(page).to have_content('Titanic')
      expect(page).to have_content('Vote Average: 7.9')
    end

    it 'links to show page', :vcr do
      visit movies_path

      click_on('Find Top Rated Movies')
      click_on('The Suicide Squad')

      expect(current_path).to eq('/movies/436969')
    end
  end
end
