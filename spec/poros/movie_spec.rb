require 'rails_helper'

RSpec.describe Movie do
  before(:each) do
    @data = {original_title: 'Aladdin', vote_average: '7.8', runtime: '245', genres: ['comedy', 'animation'], overview: 'A genie comes out of a bottle', id: 4}
  end

  describe 'attributes' do
    it 'exists' do
      expect(Movie.new(@data)).to be_an_instance_of(Movie)
    end
  end

  describe 'instance methods' do
    
  end
end
