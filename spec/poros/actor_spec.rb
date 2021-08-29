require 'rails_helper'

RSpec.describe Actor do
  describe 'attributes' do
    it 'exists' do
      @data = {name: 'Robin Williams', character: 'Genie', known_for_department: 'Acting'}
      expect(Actor.new(@data)).to be_an_instance_of(Actor)
    end
  end

  describe 'instance methods' do

  end
end
