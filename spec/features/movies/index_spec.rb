require 'rails_helper'

RSpec.describe 'Movies Index' do
  describe 'top 40 movies' do
    before(:each) do
      @user1 = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)

      json_response = File.read('spec/fixtures/top_40_movies.json')
      stub_request(:get, "https://api.themoviedb.org/3/discover/movie?api_key=bf577430a36611e1e70e3fd900b3d9ba&language=en&page=1&sort_by=popularity.desc").
           with(
             headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent'=>'Faraday v1.7.0'
             }).
           to_return(status: 200, body: json_response, headers: {})
    end

    it 'grabs top 40 movies from discover page' do
      visit '/discover'
      click_on('Find Top Rated Movies')

      expect(current_path).to eq(movies_path)
      expect('The Suicide Squad').to_appear_before('PAW Patrol: The Movie')
      expect("Zack Snyder's Justice League").to_appear_before("The Conjuring: The Devil Made Me Do It")
    end

    it 'grabs top 40 movies from movies page' do
      visit movies_path

      expect('The Suicide Squad').to_appear_before('PAW Patrol: The Movie')
      expect("Zack Snyder's Justice League").to_appear_before("The Conjuring: The Devil Made Me Do It")
    end
  end

  describe 'search' do
    before(:each) do
      @user1 = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)

      json_response = File.read('spec/fixtures/top_40_movies.json')
      stub_request(:get, "https://api.themoviedb.org/3/discover/movie?api_key=bf577430a36611e1e70e3fd900b3d9ba&language=en&page=1&sort_by=popularity.desc").
           with(
             headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent'=>'Faraday v1.7.0'
             }).
           to_return(status: 200, body: json_response, headers: {})
    end

    xit 'grabs movies by title search' do

    end
  end
end
