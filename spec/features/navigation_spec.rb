require 'rails_helper'

RSpec.describe 'Site Navigation', type: :view do
  before :each do
    @user_1 = User.create(name: 'Morgan', email: 'morgan@example.com', password: 'securepassword', password_confirmation: 'securepassword')
    @user_2 = User.create(name: 'Jackie Chan', email: 'its@jackie.com', password: 'securepassword', password_confirmation: 'securepassword')
    @image_1 = assign(:image, Image.create!(
      title: "MyString",
      body: "MyText",
      keyword: "MyString",
      user_id: @user_1.id
    ))
    @image_2 = assign(:image, Image.create!(
      title: "MyString",
      body: "MyText",
      keyword: "MyString",
      user_id: @user_1.id
    ))
    @image_3 = assign(:image, Image.create!(
      title: "MyString",
      body: "MyText",
      keyword: "MyString",
      user_id: @user_2.id
    ))
    @image_4 = assign(:image, Image.create!(
      title: "MyString",
      body: "MyText",
      keyword: "MyString",
      user_id: @user_2.id
    ))
  end

  describe 'As a Visitor', type: :feature do
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

  describe 'As a User', type: :feature do
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
