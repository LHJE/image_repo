require 'rails_helper'
include ActionView::Helpers::NumberHelper

RSpec.describe 'New Image' do
  describe 'As a visitor' do
    it 'is send back to /images' do
      visit '/images/new'

      expect(page).to have_content('This Page Only Accessible by Authenticated Users. Please Log In.')
    end
  end

  describe 'As a user' do
    before :each do
      @user = User.create!(name: 'Morgan', email: 'morgan@example.com', password: 'securepassword', password_confirmation: 'securepassword')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      @image = Image.create(keyword: "cat", url: "https://images.unsplash.com/photo-1561948955-570b270e7c36?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=518&q=80")
      visit '/images'
    end

    it 'can see go to /images/new when link clicked' do
      click_link 'Upload An Image'
      expect(current_path).to eq('/images/new')
    end

    it 'can upload an image' do
      visit '/images/new'

      fill_in 'Keyword', with: @image.keyword
      fill_in 'Url', with: @image.url
      click_button 'Submit'

      expect(current_path).to eq('/images')
      expect(page).to have_content("#{@image.keyword.capitalize} Image Uploaded!")
      expect(Image.all[0].keyword).to eq(@image.keyword)
    end

    it 'cannot upload an image without keyword' do
      visit '/images/new'

      fill_in 'Url', with: @image.url
      click_button 'Submit'

      expect(page).to have_content("keyword: [\"can't be blank\"]")
    end

    it 'cannot upload an image without Url' do
      visit '/images/new'

      fill_in 'Keyword', with: @image.keyword
      click_button 'Submit'

      expect(page).to have_content("url: [\"can't be blank\"]")
    end
  end
end
