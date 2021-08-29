require 'rails_helper'

RSpec.describe Review do
  describe 'attributes' do
    it 'exists' do
      @data = { author: 'Carina S.', content: 'A whole new world.'}
      expect(Review.new(@data)).to be_an_instance_of(Review)
    end
  end

  describe 'instance methods' do

  end
end
