require 'rails_helper'
include ActionView::Helpers::NumberHelper

RSpec.describe 'Welcome Page' do
  describe 'As a visitor' do
    before :each do
      visit root_path
    end

    it 'can see welcome message' do
      expect(page).to have_content("Welcome to Luke's Image Repo!")
    end

    it 'can see link to image repo' do
      expect(page).to have_link("Click Here To See The Image's!")
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

    it 'can send visitor to /login when Log In is clicked' do
      within '.login' do
        click_link 'Register'
      end

      expect(current_path).to eq(registration_path)
    end

    it 'can send visitor to /images when link clicked' do
      click_link "Click Here To See The Image's!"

      expect(current_path).to eq(images_path)
    end
  end

  describe 'As a logged in user' do
    before :each do
      @user = User.create(name: 'Morgan', email: 'morgan@example.com', password: 'securepassword')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit root_path
    end

    it "can see greeting noting user is logged in" do
      expect(page).to have_content("You're logged in Morgan!")
    end

    it 'can see link to image repo' do
      expect(page).to have_link("Click Here To See The Image's!")
    end

    it 'can send user to /images when link clicked' do
      click_link "Click Here To See The Image's!"

      expect(current_path).to eq(images_path)
    end
  end
end
