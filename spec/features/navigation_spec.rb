require 'rails_helper'

RSpec.describe 'Site Navigation' do
  describe 'As a Visitor' do
    describe 'I see a nav bar where I can link to' do
      it 'the welcome page' do
        visit login_path

        within 'nav' do
          click_link 'Home'
        end

        expect(current_path).to eq(root_path)
      end

      it 'the login page' do
        visit root_path

        within 'nav' do
          click_link 'Log In'
        end

        expect(current_path).to eq(login_path)
      end

    end
  end
end
