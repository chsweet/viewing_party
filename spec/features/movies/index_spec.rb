require 'rails_helper'

RSpec.describe 'Movies Index' do
  before(:each) do
    @user1 = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
  end

  it 'grabs top 40 movies' do
    visit movies_path

    expect(page).to have_content('The Suicide Squad')
  end
end
