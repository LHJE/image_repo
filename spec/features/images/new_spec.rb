require 'rails_helper'
include ActionView::Helpers::NumberHelper

RSpec.describe 'New Image', type: :view do
  before :each do
    @user_1 = User.create(name: 'Morgan', email: 'morgan@example.com', password: 'securepassword', password_confirmation: 'securepassword')
    @user_2 = User.create(name: 'Jackie Chan', email: 'its@jackie.com', password: 'securepassword', password_confirmation: 'securepassword')
    @image_1 = assign(:image, Image.create!(
      title: "MyString1",
      body: "MyText1",
      keyword: "MyString1",
      user_id: @user_1.id
    ))
    @image_2 = assign(:image, Image.create!(
      title: "MyString2",
      body: "MyText2",
      keyword: "MyString2",
      user_id: @user_1.id
    ))
    @image_3 = assign(:image, Image.create!(
      title: "MyString3",
      body: "MyText3",
      keyword: "MyString3",
      user_id: @user_2.id
    ))
    @image_4 = assign(:image, Image.create!(
      title: "MyString4",
      body: "MyText4",
      keyword: "MyString4",
      user_id: @user_2.id
    ))

    @new_image = {title: "Title", body: "It's the Body", keyword: "Keyword"}
  end

  describe 'As a visitor', type: :feature do
    it 'is send back to /images' do
      visit '/images/new'

      expect(page).to have_content('This Page Only Accessible by Authenticated Users. Please Log In.')
    end
  end

  describe 'As a user', type: :feature do
    before :each do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)

      visit '/images'
    end

    it 'can see go to /images/new when link clicked' do
      click_link 'Upload An Image'
      expect(current_path).to eq('/images/new')
    end

    it 'can upload an image' do
      visit '/images/new'

      fill_in 'Title', with: @new_image[:title]
      fill_in 'Body', with: @new_image[:body]
      fill_in 'Keyword', with: @new_image[:keyword]

      click_button 'Create Image'

      expect(current_path).to eq("/images/#{Image.all[-1].id}")
      expect(page).to have_content("Image was successfully created.")
      expect(Image.all[-1].keyword).to eq(@new_image[:keyword])
    end

    it 'cannot upload an image without all fields filled in' do
      visit '/images/new'

      click_button 'Create Image'

      expect(page).to have_content("3 errors prohibited this image from being saved:")
      expect(page).to have_content("Title can't be blank")
      expect(page).to have_content("Body can't be blank")
      expect(page).to have_content("Keyword can't be blank")
    end

    it 'can see an uploaded an image on the index, at the top' do
      visit '/images/new'

      fill_in 'Title', with: @new_image[:title]
      fill_in 'Body', with: @new_image[:body]
      fill_in 'Keyword', with: @new_image[:keyword]

      click_button 'Create Image'

      visit '/images'

      within "#image-#{Image.all[-1].id}" do
        expect(page).to have_content(@new_image[:title])
      end
    end
  end
end
