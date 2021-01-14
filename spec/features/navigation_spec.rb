require 'rails_helper'

RSpec.describe 'Site Navigation' do
  before :each do
    @user_1 = User.create(name: 'Morgan', email: 'morgan@example.com', password: 'securepassword', password_confirmation: 'securepassword')
    @user_2 = User.create(name: 'Jackie Chan', email: 'its@jackie.com', password: 'securepassword', password_confirmation: 'securepassword')
    @image_1 = @user_1.images.create(keyword: "cat", url: "https://images.unsplash.com/photo-1561948955-570b270e7c36?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=518&q=80")
    @image_2 = @user_1.images.create(keyword: "dog", url: "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/20122208/Samoyed-standing-in-the-forest.jpg")
    @image_3 = @user_2.images.create(keyword: "cat", url: "https://www.mcgill.ca/oss/files/oss/styles/hd/public/cute-3281819_1920.jpg?itok=1tLaIhp2&timestamp=1569533232")
    @image_4 = @user_2.images.create(keyword: "moose", url: "https://res.cloudinary.com/sagacity/image/upload/c_crop,h_3481,w_3481,x_0,y_0/c_limit,dpr_auto,f_auto,fl_lossy,q_80,w_1080/moose.shutter_t5itks.jpg")
  end

  describe 'As a Visitor' do
    describe 'I see a nav bar where I can link to' do
      it 'the nav bar' do
        visit root_path

        within 'nav' do
          expect(page).to have_link("Home")
          expect(page).to have_link("All Images")
          expect(page).to have_link("Log In")
          expect(page).to have_link("Register")
          expect(page).to have_button("Search With One Keyword")
        end
      end

      it 'the welcome page' do
        visit login_path

        within 'nav' do
          click_link 'Home'
        end

        expect(current_path).to eq(root_path)
      end

      it 'the images page' do
        visit login_path

        within 'nav' do
          click_link 'All Images'
        end

        expect(current_path).to eq('/images')
      end

      it 'the login page' do
        visit root_path

        within 'nav' do
          click_link 'Log In'
        end

        expect(current_path).to eq(login_path)
      end

      it 'the registraton page' do
        visit root_path

        within 'nav' do
          click_link 'Register'
        end

        expect(current_path).to eq(registration_path)
      end

      it 'can Search With One Keyword' do
        visit root_path

        within 'nav' do
          fill_in :keyword, with: @image_1.keyword
          click_button 'Search With One Keyword'
        end

        expect(current_path).to eq('/search')
        expect(page).to_not have_content(@image_2.keyword.capitalize)
        expect(page).to_not have_content(@image_4.keyword.capitalize)
        within "#image-#{@image_1.id}" do
          expect(page).to have_content(@image_1.keyword.capitalize)
        end
        within "#image-#{@image_3.id}" do
          expect(page).to have_content(@image_3.keyword.capitalize)
        end
      end
    end
  end

  describe 'As a User' do
    before :each do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
    end

    describe 'I see a nav bar where I can link to' do
      it 'the nav bar' do
        visit root_path

        within 'nav' do
          expect(page).to have_link("Home")
          expect(page).to have_link("All Images")
          expect(page).to have_link("Log Out")
          expect(page).to have_button("Search With One Keyword")
        end
      end

      it 'the welcome page' do
        visit '/images'

        within 'nav' do
          click_link 'Home'
        end

        expect(current_path).to eq(root_path)
      end

      it 'the images page' do
        visit login_path

        within 'nav' do
          click_link 'All Images'
        end

        expect(current_path).to eq('/images')
      end

      it 'the logout page' do
        visit root_path

        within 'nav' do
          click_link 'Log Out'
        end

        expect(current_path).to eq(root_path)
        expect(page).to have_content('You have been logged out!')
      end
      
      it 'can Search With One Keyword' do
        visit root_path

        within 'nav' do
          fill_in :keyword, with: @image_1.keyword
          click_button 'Search With One Keyword'
        end

        expect(current_path).to eq('/search')
        expect(page).to_not have_content(@image_2.keyword.capitalize)
        expect(page).to_not have_content(@image_4.keyword.capitalize)
        within "#image-#{@image_1.id}" do
          expect(page).to have_content(@image_1.keyword.capitalize)
        end
        within "#image-#{@image_3.id}" do
          expect(page).to have_content(@image_3.keyword.capitalize)
        end
      end
    end

    describe 'I do not see in my nav bar' do
      it 'the login link' do
        visit root_path

        expect(page).to_not have_link('Log In')
      end

      it 'the registration link' do
        visit root_path

        expect(page).to_not have_link('Register')
      end
    end
  end
end
