require 'rails_helper'
include ActionView::Helpers::NumberHelper

RSpec.describe 'New Image' do
  describe 'As a user' do
    before :each do
      @user = User.create!(name: 'Morgan', email: 'morgan@example.com', password: 'securepassword', password_confirmation: 'securepassword')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit '/images'
    end

    it 'can see go to /images/new when link clicked' do
      click_link 'Upload An Image'
      expect(current_path).to eq('/images/new')
    end
  end
end
