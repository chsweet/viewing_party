require 'rails_helper'

RSpec.describe Movie do
  before(:each) do
    @data = {original_title: 'Aladdin', vote_average: 7.8, runtime: 139, genres: [{id: 18, name: 'comedy'}, {id: 5, name: 'animation'}], overview: 'A genie comes out of a bottle', id: 4}
    @data2 = {original_title: 'Aladdin', vote_average: 7.8, runtime: 175, genres: [{id: 18, name: 'comedy'}, {id: 5, name: 'animation'}], overview: 'A genie comes out of a bottle', id: 4}
  end

  describe 'attributes' do
    it 'exists' do
      expect(Movie.new(@data)).to be_an_instance_of(Movie)
    end
  end

  describe 'instance methods' do
    before(:each) do
      @movie = Movie.new(@data)
      @movie2 = Movie.new(@data2)
    end

    describe 'genre names' do
      it 'returns an array of movie genres' do
        expect(@movie.genre_names(@data[:genres])).to eq(['comedy', 'animation'])
      end
    end

    describe 'hours' do
      it 'returns movie hours' do
        expect(@movie.hours).to eq(2)
        expect(@movie2.hours).to eq(2)
      end
    end

    describe 'minutes' do
      it 'returns movie minutes' do
        expect(@movie.minutes).to eq(19)
      end
    end
  end
end
