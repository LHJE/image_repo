require 'rails_helper'
include ActionView::Helpers::NumberHelper

RSpec.describe 'Welcome Page' do
  describe 'As a visitor' do
    before :each do
      visit root_path
    end

    it 'can see welcome message' do
      expect(page).to have_content('Welcome to the Image Repo!')
    end

    it 'can see login/register prompt' do
      expect(page).to have_content('Please Log In or Register!')
    end

    it 'can see login link' do
      expect(page).to have_link('Log In')
    end

    it 'can see register link' do
      expect(page).to have_link('Register')
    end

    it 'can send visitor to /login when Log In is clicked' do
      within '.login' do
        click_link 'Log In'
      end

      expect(current_path).to eq(login_path)
    end
  end
end
