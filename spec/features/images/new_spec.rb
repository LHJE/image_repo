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
      @image_1 = @user.images.create(keyword: "cat", url: "https://images.unsplash.com/photo-1561948955-570b270e7c36?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=518&q=80")
      @image_2 = @user.images.create(keyword: "dog", url: "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/20122208/Samoyed-standing-in-the-forest.jpg")
      @image_3 = @user.images.create(keyword: "mouse", url: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0d/%D0%9C%D1%8B%D1%88%D1%8C_2.jpg/440px-%D0%9C%D1%8B%D1%88%D1%8C_2.jpg")
      @image_4 = @user.images.create(keyword: "moose", url: "https://res.cloudinary.com/sagacity/image/upload/c_crop,h_3481,w_3481,x_0,y_0/c_limit,dpr_auto,f_auto,fl_lossy,q_80,w_1080/moose.shutter_t5itks.jpg")

      @new_image = Image.create(keyword: "lion", url: "https://www.goway.com/media/cache/aa/79/aa79264f49aae4d4b2d77f0abdeb16fc.jpg")

      visit '/images'
    end

    it 'can see go to /images/new when link clicked' do
      click_link 'Upload An Image'
      expect(current_path).to eq('/images/new')
    end

    it 'can upload an image' do
      visit '/images/new'

      fill_in 'Keyword', with: @new_image.keyword
      fill_in 'Url', with: @new_image.url
      click_button 'Submit'

      expect(current_path).to eq('/images')
      expect(page).to have_content("#{@new_image.keyword.capitalize} Image Uploaded!")
      expect(Image.all[-1].keyword).to eq(@new_image.keyword)
    end

    it 'cannot upload an image without keyword' do
      visit '/images/new'

      fill_in 'Url', with: @new_image.url
      click_button 'Submit'

      expect(page).to have_content("keyword: [\"can't be blank\"]")
    end

    it 'cannot upload an image without Url' do
      visit '/images/new'

      fill_in 'Keyword', with: @new_image.keyword
      click_button 'Submit'

      expect(page).to have_content("url: [\"can't be blank\"]")
    end

    it 'can see an uploaded an image on the index, at the top' do
      visit '/images/new'

      fill_in 'Keyword', with: @new_image.keyword
      fill_in 'Url', with: @new_image.url
      click_button 'Submit'

      within "#image-#{Image.all[-1].id}" do
        expect(page).to have_content(@new_image.keyword)
      end
    end
  end
end
