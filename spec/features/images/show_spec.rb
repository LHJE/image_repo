require 'rails_helper'
include ActionView::Helpers::NumberHelper

RSpec.describe 'Images Show' do
  describe 'As any user' do
    before :each do
      @user_1 = User.create(name: 'Morgan', email: 'morgan@example.com', password: 'securepassword', password_confirmation: 'securepassword')
      @user_2 = User.create(name: 'Jackie Chan', email: 'its@jackie.com', password: 'securepassword', password_confirmation: 'securepassword')
      @image_1 = @user_1.images.create(keyword: "cat", url: "https://images.unsplash.com/photo-1561948955-570b270e7c36?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=518&q=80")
      @image_2 = @user_1.images.create(keyword: "dog", url: "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/20122208/Samoyed-standing-in-the-forest.jpg")
      @image_3 = @user_2.images.create(keyword: "mouse", url: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0d/%D0%9C%D1%8B%D1%88%D1%8C_2.jpg/440px-%D0%9C%D1%8B%D1%88%D1%8C_2.jpg")
      @image_4 = @user_2.images.create(keyword: "moose", url: "https://res.cloudinary.com/sagacity/image/upload/c_crop,h_3481,w_3481,x_0,y_0/c_limit,dpr_auto,f_auto,fl_lossy,q_80,w_1080/moose.shutter_t5itks.jpg")
      visit '/images'
    end

    describe 'as a visitor' do
      it 'click on image and be sent to that image show page' do
        within "#image-#{@image_1.id}" do
          click_link @image_1.keyword.capitalize
        end

        expect(current_path).to eq("/images/#{@image_1.id}")
      end

      it "can see all information about the image, but not update or delete" do
        within "#image-#{@image_1.id}" do
          click_link @image_1.keyword.capitalize
        end

        expect(page).to have_content(@image_1.keyword.capitalize)
        expect(page).to_not have_link("Update Image")
        expect(page).to_not have_link("Delete Image")
      end

    end

    describe 'As a user' do
      before :each do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
        visit '/images'
      end

      it 'click on image and be sent to that image show page' do
        within "#image-#{@image_1.id}" do
          click_link @image_1.keyword.capitalize
        end

        expect(current_path).to eq("/images/#{@image_1.id}")
      end

      it "can see all information about the image, including update and delete" do
        within "#image-#{@image_1.id}" do
          click_link @image_1.keyword.capitalize
        end

        expect(page).to have_content(@image_1.keyword.capitalize)
        expect(page).to have_link("Update Image")
        expect(page).to have_link("Delete Image")
      end

      it "can click on Update Image and be sent to edit page" do
        within "#image-#{@image_1.id}" do
          click_link @image_1.keyword.capitalize
        end

        click_link("Update Image")
        expect(current_path).to eq("/images/#{@image_1.id}/edit")
      end
    end
  end

end
