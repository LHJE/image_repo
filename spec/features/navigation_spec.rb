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

      it 'the registraton page' do
        visit root_path

        within 'nav' do
          click_link 'Register'
        end

        expect(current_path).to eq(registration_path)
      end
    end
  end

  describe 'As a User' do
    before :each do
      @user = User.create(name: 'Morgan', email: 'morgan@example.com', password: 'securepassword')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    describe 'I see a nav bar where I can link to' do
      it 'the welcome page' do
        visit '/images'

        within 'nav' do
          click_link 'Home'
        end

        expect(current_path).to eq(root_path)
      end

    end
  end
end
