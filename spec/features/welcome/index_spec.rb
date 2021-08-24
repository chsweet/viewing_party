require 'rails_helper'

RSpec.describe 'Welcome Page' do
  describe 'user' do
    before(:each) do
      visit root_path
    end
    it 'sees welcome message' do
      expect(page).to have_content('Welcome to Viewing Party')
    end

    it 'sees brief description of app' do
      expect(page).to have_content('Viewing Party is an app that allows you to create movie events with your friends')
    end

    it 'can navigate to registration page' do
      click_on('New to Viewing Party? Register Here')

      expect(current_path).to eq(new_user_path)
    end

    describe 'login' do
      it 'can authenticate with correct inputs' do
        user = create(:user, password: 'password1')

        fill_in(:email, with:(user.email))
        fill_in(:password, with:(user.password))
        click_on('Sign In')

        expect(current_path).to eq(dashboard_path)
      end

      it 'cannot authenticate with wrong inputs' do
        user = create(:user)

        fill_in(:email, with:(user.email))
        fill_in(:password, with:('wrong_password'))
        click_on('Sign In')

        expect(current_path).to eq(root_path)
        expect(page).to have_content('The username or password you entered is incorrect')

        fill_in(:email, with:('wrong@email.com'))
        fill_in(:password, with:(user.password))
        click_on('Sign In')

        expect(current_path).to eq(root_path)
        expect(page).to have_content('Account does not exist. Have you tried registering?')
      end
    end
  end
end
