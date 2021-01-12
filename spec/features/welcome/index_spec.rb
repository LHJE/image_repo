require 'rails_helper'
include ActionView::Helpers::NumberHelper

RSpec.describe 'Welcome Page' do
  describe 'As a visitor' do
    before :each do
      visit root_path
    end

    it "can see welcome message" do
      expect(page).to have_content("Welcome to the Image Repo!")
    end

    it "can see login/register prompt" do
      expect(page).to have_content("Please Log In or Register!")
    end

  end
end
