require 'rails_helper'
include ActionView::Helpers::NumberHelper

RSpec.describe 'Welcome Page' do
  describe 'As a visitor' do
    before :each do
      visit root_path
    end

    it "can see welcome message" do
      expect(page).to have_content("Welcome to the Login Page!")
    end
  end
end
