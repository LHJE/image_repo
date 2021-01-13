require 'rails_helper'

RSpec.describe 'User Registration' do
  describe 'As a Visitor' do
    it 'I see a link to register as a user' do
      visit root_path
      within 'nav' do
        click_link 'Register'
      end

      expect(current_path).to eq(registration_path)
    end

    it 'I see a link to register as a user' do
      visit root_path
      within '.login' do
        click_link 'Register'
      end

      expect(current_path).to eq(registration_path)
    end

    
  end
end
