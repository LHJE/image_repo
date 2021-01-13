require 'rails_helper'
include ActionView::Helpers::NumberHelper

RSpec.describe 'Images Update' do
  describe 'As any user' do
    before :each do
      @user_1 = User.create(name: 'Morgan', email: 'morgan@example.com', password: 'securepassword', password_confirmation: 'securepassword')
      @user_2 = User.create(name: 'Jackie Chan', email: 'its@jackie.com', password: 'securepassword', password_confirmation: 'securepassword')
      @image_1 = @user_1.images.create(keyword: "cat", url: "https://images.unsplash.com/photo-1561948955-570b270e7c36?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=518&q=80")
      @image_2 = @user_1.images.create(keyword: "dog", url: "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/20122208/Samoyed-standing-in-the-forest.jpg")
      @image_3 = @user_2.images.create(keyword: "mouse", url: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0d/%D0%9C%D1%8B%D1%88%D1%8C_2.jpg/440px-%D0%9C%D1%8B%D1%88%D1%8C_2.jpg")
      @image_4 = @user_2.images.create(keyword: "moose", url: "https://res.cloudinary.com/sagacity/image/upload/c_crop,h_3481,w_3481,x_0,y_0/c_limit,dpr_auto,f_auto,fl_lossy,q_80,w_1080/moose.shutter_t5itks.jpg")
      visit '/images'
      within "#image-#{@image_1.id}" do
        click_link @image_1.keyword.capitalize
      end
    end

    describe 'as a visitor' do
      it 'cannot update an image if they did not upload it' do
        visit "/images/#{@image_1.id}/edit"

        expect(current_path).to eq("/images/#{@image_1.id}")
        expect(page).to have_content('You are not authorized to update this image!')
      end

    end

    describe 'As a user' do
      before :each do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
        visit "/images/#{@image_1.id}/edit"
      end

      it 'cannot update an image if they did not upload it' do
        visit "/images/#{@image_4.id}/edit"

        expect(current_path).to eq("/images/#{@image_4.id}")
        expect(page).to have_content('You are not authorized to update this image!')
      end

    end
  end

end
