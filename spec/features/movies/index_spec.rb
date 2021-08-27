require 'rails_helper'

RSpec.describe 'Movies Index' do
  before(:each) do
    @user1 = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)

    json_top_response = File.read('spec/fixtures/top_40_movies.json')
    stub_request(:get, "https://api.themoviedb.org/3/discover/movie?api_key=bf577430a36611e1e70e3fd900b3d9ba&language=en&sort_by=popularity.desc").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v1.7.0'
           }).
         to_return(status: 200, body: json_top_response, headers: {})

     stub_request(:get, "https://api.themoviedb.org/3/discover/movie?1&api_key=bf577430a36611e1e70e3fd900b3d9ba&language=en&sort_by=popularity.desc").
    with(
      headers: {
     'Accept'=>'*/*',
     'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
     'User-Agent'=>'Faraday v1.7.0'
      }).
    to_return(status: 200, body: json_top_response, headers: {})

     json_titanic_response = File.read('spec/fixtures/titanic_search.json')
     stub_request(:get, "https://api.themoviedb.org/3/search/movie/?api_key=bf577430a36611e1e70e3fd900b3d9ba&query=titanic").
        with(
          headers: {
         'Accept'=>'*/*',
         'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
         'User-Agent'=>'Faraday v1.7.0'
          }).
        to_return(status: 200, body: json_titanic_response, headers: {})

      stub_request(:get, "https://api.themoviedb.org/3/search/movie/?1&api_key=bf577430a36611e1e70e3fd900b3d9ba&query=titanic").
       with(
         headers: {
     	  'Accept'=>'*/*',
     	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
     	  'User-Agent'=>'Faraday v1.7.0'
         }).
       to_return(status: 200, body: json_titanic_response, headers: {})
  end

  describe 'top 40 movies' do
    it 'grabs top 40 movies from discover page' do
      visit '/discover'
      click_on('Find Top Rated Movies')

      expect(current_path).to eq(movies_path)
      expect('The Suicide Squad').to appear_before('PAW Patrol: The Movie')
      expect("Zack Snyder's Justice League").to appear_before("The Conjuring: The Devil Made Me Do It")
    end

    it 'grabs top 40 movies from movies page' do
      visit movies_path

      expect('The Suicide Squad').to appear_before('PAW Patrol: The Movie')
      expect("Zack Snyder's Justice League").to appear_before("The Conjuring: The Devil Made Me Do It")
    end
  end

  describe 'search' do
    before(:each) do
      @user1 = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)


    end

    it 'grabs movies by title search from discover page' do
      visit '/discover'

      fill_in(:search, with:('Titanic'))
      click_on('Find Movies')

      expect(current_path).to eq(movies_path)
      expect(page).to have_content('Titanic')
      expect(page).to have_content('Vote Average: 7.9')
    end

    it 'grabs movies by title search from movies page' do
      visit movies_path

      fill_in(:search, with:('Titanic'))
      click_on('Find Movies')

      expect(current_path).to eq(movies_path)
      expect(page).to have_content('Titanic')
      expect(page).to have_content('Vote Average: 7.9')
    end

    it 'search is not case sensitive' do
      visit movies_path

      fill_in(:search, with:('TiTanIC'))
      click_on('Find Movies')

      expect(current_path).to eq(movies_path)
      expect(page).to have_content('Titanic')
      expect(page).to have_content('Vote Average: 7.9')
    end

    it 'links to show page' do
      visit movies_path

      click_on('Find Top Rated Movies')
      click_on('The Suicide Squad')

      expect(current_path).to eq('/movies/436969')
    end
  end
end
