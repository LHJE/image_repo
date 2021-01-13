require 'rails_helper'

RSpec.describe 'User Registration' do
  describe 'As a Visitor' do
    it 'I see a link to register as a user' do
      visit root_path
      within 'nav' do
        click_link 'Register'
      end

      expect(current_path).to eq(registration_path)
    end

    it 'I see a link to register as a user' do
      visit root_path
      within '.login' do
        click_link 'Register'
      end

      expect(current_path).to eq(registration_path)
    end

    it 'I can register as a user' do
      visit registration_path

      fill_in 'Name', with: 'Morgan'
      fill_in 'Email', with: 'morgan@example.com'
      fill_in 'Password', with: 'securepassword'
      fill_in 'Password confirmation', with: 'securepassword'
      click_button 'Register'

      expect(current_path).to eq('/images')
      expect(page).to have_content('Welcome, Morgan!')
    end

  end
end
