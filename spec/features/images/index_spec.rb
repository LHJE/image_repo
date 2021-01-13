require 'rails_helper'
include ActionView::Helpers::NumberHelper

RSpec.describe 'Images Index' do
  describe 'As a visitor' do
    before :each do
      visit '/images'
    end

    it 'can see base headers' do
      expect(page).to have_content("The Image Repo!")
      expect(page).to have_content("The Images, most recent at the top:")
      expect(page).to_not have_link("Upload An Image")
      expect(page).to have_content("Search:")
    end
  end

  describe 'As a user' do
    before :each do
      @user = User.create!(name: 'Morgan', email: 'morgan@example.com', password: 'securepassword', password_confirmation: 'securepassword')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit '/images'
    end

    it 'can see base headers' do
      expect(page).to have_content("The Image Repo!")
      expect(page).to have_content("The Images, most recent at the top:")
      expect(page).to have_link("Upload An Image")
      expect(page).to have_content("Search:")
    end
  end
end
