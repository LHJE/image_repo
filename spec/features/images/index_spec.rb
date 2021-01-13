require 'rails_helper'
include ActionView::Helpers::NumberHelper

RSpec.describe 'Image Page' do
  describe 'As a visitor' do
    before :each do
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
