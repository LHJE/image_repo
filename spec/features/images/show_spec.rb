require 'rails_helper'
include ActionView::Helpers::NumberHelper

RSpec.describe 'Images Show', type: :view do
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

  describe 'as a visitor', type: :feature do
    before :each do
      visit '/images'
    end

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

  describe 'As a user', type: :feature do
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

    it "can click on Update Image and be sent to edit page" do
      within "#image-#{@image_1.id}" do
        click_link @image_1.keyword.capitalize
      end

      click_link("Delete Image")
      expect(current_path).to eq("/images")
      expect(Image.where(id: @image_1.id)).to eq([])
    end
  end
  end
