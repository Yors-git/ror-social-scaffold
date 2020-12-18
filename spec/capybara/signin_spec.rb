require 'rails_helper'

RSpec.describe 'Private-Events', type: :system do
  describe 'signUp' do
    scenario 'signup a new user' do
      visit 'users/sign_up'
      fill_in :user_name, with: 'Capybara'
      fill_in :user_email, with: 'capybara@test.com'
      fill_in :user_password, with: '123456'
      fill_in :user_password_confirmation, with: '123456'
      find('input[name="commit"]').click
      click_on('Sign out')
      fill_in :user_email, with: 'capybara@test.com'
      fill_in :user_password, with: '123456'
      find('input[name="commit"]').click
      expect(page).to have_content('LOGGED AS: CAPYBARA')
    end
  end
end