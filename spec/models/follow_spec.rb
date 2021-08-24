require 'rails_helper'

RSpec.describe Follow do
  describe 'relationships' do
    it {should belong_to :hosts}
    it {should belong_to :followeds}
  end
end
