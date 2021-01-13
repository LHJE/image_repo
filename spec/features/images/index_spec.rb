require 'rails_helper'
include ActionView::Helpers::NumberHelper

RSpec.describe 'Images Index' do
  describe 'As any user' do
    before :each do
      @user = User.create(name: 'Morgan', email: 'morgan@example.com', password: 'securepassword', password_confirmation: 'securepassword')
      @image_1 = @user.images.create(keyword: "cat", url: "https://images.unsplash.com/photo-1561948955-570b270e7c36?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=518&q=80")
      @image_2 = @user.images.create(keyword: "dog", url: "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/20122208/Samoyed-standing-in-the-forest.jpg")
      @image_3 = @user.images.create(keyword: "mouse", url: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0d/%D0%9C%D1%8B%D1%88%D1%8C_2.jpg/440px-%D0%9C%D1%8B%D1%88%D1%8C_2.jpg")
      @image_4 = @user.images.create(keyword: "moose", url: "https://res.cloudinary.com/sagacity/image/upload/c_crop,h_3481,w_3481,x_0,y_0/c_limit,dpr_auto,f_auto,fl_lossy,q_80,w_1080/moose.shutter_t5itks.jpg")
      visit '/images'
    end

    describe 'as a visitor' do
      it 'can see base headers' do
        expect(page).to have_content("The Image Repo!")
        expect(page).to have_content("The Images, most recent at the top:")
        expect(page).to_not have_link("Upload An Image")
        expect(page).to have_content("Please Log In or Register if you'd like to Upload an Image!")
        expect(page).to have_content("Search:")
        within '.login' do
          expect(page).to have_link("Log In")
          expect(page).to have_link("Register")
        end
      end

    end

    describe 'As a user' do
      before :each do
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

end
