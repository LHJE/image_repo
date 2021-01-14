require 'rails_helper'
include ActionView::Helpers::NumberHelper

RSpec.describe 'Images Update', type: :view do
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
    it 'cannot update an image if they did not upload it' do
      visit "/images/#{@image_1.id}/edit"

      expect(current_path).to eq("/images")
      expect(page).to have_content('You are not authorized to update this image!')
    end

  end

  describe 'As a user', type: :feature do
    before :each do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
      visit "/images/#{@image_1.id}/edit"
    end

    it "can update keyword for an image they uploaded" do

      fill_in 'Keyword', with: "kitty"

      click_button 'Update Image'

      expect(current_path).to eq("/images/#{@image_1.id}")
      expect(page).to have_content("Image Updated!")
    end

    it "can update title for an image they uploaded" do

      fill_in 'Title', with: "Big Cat"

      click_button 'Update Image'

      expect(current_path).to eq("/images/#{@image_1.id}")
      expect(page).to have_content("Image Updated!")
    end

    it "can update title for an image they uploaded" do

      fill_in 'Body', with: "It's a Big Cat!"

      click_button 'Update Image'

      expect(current_path).to eq("/images/#{@image_1.id}")
      expect(page).to have_content("Image Updated!")
    end

    it "can update all fields for an image they uploaded" do

      fill_in 'Title', with: "Big Cat"
      fill_in 'Body', with: "It's a Big Cat!"
      fill_in 'Keyword', with: "kitty"

      click_button 'Update Image'

      expect(current_path).to eq("/images/#{@image_1.id}")
      expect(page).to have_content("Image Updated!")
    end

    it "cannot update image they uploaded without all fields filled in" do
      fill_in 'Title', with: ""
      fill_in 'Body', with: ""
      fill_in 'Keyword', with: ""

      click_button 'Update Image'

      expect(current_path).to eq("/images/#{@image_1.id}")
      expect(page).to have_content("3 errors prohibited this image from being saved:")
      expect(page).to have_content("Title can't be blank")
      expect(page).to have_content("Body can't be blank")
      expect(page).to have_content("Keyword can't be blank")
    end

    it 'cannot update an image if they did not upload it' do
      visit "/images/#{@image_4.id}/edit"

      expect(current_path).to eq("/images")
      expect(page).to have_content('You are not authorized to update this image!')
    end
  end
end
