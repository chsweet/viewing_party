require 'rails_helper'

RSpec.describe Follow do
  describe 'relationships' do
    it {should belong_to :host}
    it {should belong_to :followed}
  end
end
