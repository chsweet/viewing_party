require 'rails_helper'

RSpec.describe 'registration page' do
  describe 'user' do
    it 'can create a new user account' do
      visit '/registration'
      email = 'test@email.com'
      password = 'password'

      expect(page).to have_content('Please Register for an Account')
      fill_in(:email, with:(email))
      fill_in(:password, with:(password))
      fill_in(:password_confirmation, with:(password))
      click_on('Register')

      expect(current_path).to eq(dashboard_path)
    end
  end
end
