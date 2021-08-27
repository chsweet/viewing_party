require 'rails_helper'

RSpec.describe 'Discover' do
  describe 'authenticated user' do
    before(:each) do
      @user1 = create(:user)
      json_response = File.read('spec/fixtures/top_40_movies.json')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
      stub_request(:get, "https://api.themoviedb.org/3/discover/movie?1&api_key=bf577430a36611e1e70e3fd900b3d9ba&language=en&sort_by=popularity.desc").
        with(
          headers: {
         'Accept'=>'*/*',
         'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
         'User-Agent'=>'Faraday v1.7.0'
          }).
        to_return(status: 200, body: json_response, headers: {})

      stub_request(:get, "https://api.themoviedb.org/3/discover/movie?api_key=bf577430a36611e1e70e3fd900b3d9ba&language=en&page=1&sort_by=popularity.desc").
      with(
        headers: {
       'Accept'=>'*/*',
       'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       'User-Agent'=>'Faraday v1.7.0'
        }).
      to_return(status: 200, body: json_response, headers: {})

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

        stub_request(:get, "https://api.themoviedb.org/3/search/movie/?api_key=bf577430a36611e1e70e3fd900b3d9ba&page=1&query=titanic").
         with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'User-Agent'=>'Faraday v1.7.0'
           }).
         to_return(status: 200, body: json_titanic_response, headers: {})
      visit('/discover')
    end

    it 'can find top rated movies' do
      expect(page).to have_content("Welcome #{@user1.email}")
      click_on('Find Top Rated Movies')

      expect(current_path).to eq(movies_path)
    end

    it 'can search by movie title' do
      fill_in(:search, with:('Titanic'))
      click_on('Find Movies')

      expect(current_path).to eq(movies_path)
    end
  end

  describe 'unauthenticated user' do
    it 'redirects to root path' do
      visit('/discover')
      expect(current_path).to eq(root_path)
      expect(page).to have_content("Uh Oh, Can't go there! Try logging in or registering as a new user.")
    end
  end
end
