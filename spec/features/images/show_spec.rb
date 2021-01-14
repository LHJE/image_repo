require 'rails_helper'
include ActionView::Helpers::NumberHelper

RSpec.describe 'Images Show', type: :view do
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
  end

  describe 'as a visitor', type: :feature do
    before :each do
      visit '/images'
    end

    it 'click on image and be sent to that image show page' do

      within "#image-#{@image_1.id}" do
        click_link 'Show'
      end


      expect(current_path).to eq("/images/#{@image_1.id}")
    end

    it "can see all information about the image, but not update or delete" do

      within "#image-#{@image_1.id}" do
        click_link 'Show'
      end

      expect(page).to have_content(@image_1.title)
      expect(page).to_not have_link("Update Image")
      expect(page).to_not have_link("Delete Image")
    end

  end

  describe 'As a user', type: :feature do
    before :each do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
      visit '/images'
    end

    it 'click on image and be sent to that image show page' do
      within "#image-#{@image_1.id}" do
        click_link 'Show'
      end

      expect(current_path).to eq("/images/#{@image_1.id}")
    end

    it "can see all information about the image, including update and delete" do
      within "#image-#{@image_1.id}" do
        click_link 'Show'
      end

      expect(page).to have_content(@image_1.title)
      expect(page).to have_link("Edit")
      expect(page).to have_link("Back")
    end

    it "can click on Update Image and be sent to edit page" do
      within "#image-#{@image_1.id}" do
        click_link 'Show'
      end

      click_link("Edit")
      expect(current_path).to eq("/images/#{@image_1.id}/edit")
    end

  end
end
