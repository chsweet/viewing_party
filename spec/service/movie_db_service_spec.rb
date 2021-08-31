require 'rails_helper'

RSpec.describe MovieDbService do
  describe 'top 40 movies' do
    before(:each) do
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

    # it 'can retrieve top 40 movies', :vcr do
    #   result = MovieDbService.new.top_40
    #   expect(result.length).to eq(40)
    #   expect(result.first[:original_title]).to eq('The Suicide Squad')
    # end
  end
end
