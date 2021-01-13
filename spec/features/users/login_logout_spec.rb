require 'rails_helper'

RSpec.describe 'User Login and Log Out' do
  describe 'A registered user can log in' do
    describe 'As a default user' do
      before :each do
        @user = User.create!(name: 'Morgan', email: 'morgan@example.com', password: 'securepassword', password_confirmation: 'securepassword')
      end

      it 'can log in with correct credentials' do
        visit login_path

        fill_in 'Email', with: @user.email
        fill_in 'Password', with: @user.password
        click_button 'Log In'

        expect(current_path).to eq('/images')
        expect(page).to have_content("Logged in as #{@user.name}")
      end

      it 'users already logged in will be redirected' do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

        visit login_path

        expect(current_path).to eq('/images')
        expect(page).to have_content('You are already logged in!')
      end
    end
  end

  describe 'A registered user can not log in with bad credentials' do
    before :each do
      @user = User.create!(name: 'Morgan', email: 'morgan@example.com', password: 'securepassword', password_confirmation: 'securepassword')
    end

    it 'incorrect email' do
      visit login_path

      fill_in 'Email', with: 'bad@email.com'
      fill_in 'Password', with: @user.password
      click_button 'Log In'

      expect(page).to have_content('Your email or password was incorrect!')
      expect(page).to have_button('Log In')
    end

    it 'incorrect password' do
      visit login_path

      fill_in 'Email', with: @user.email
      fill_in 'Password', with: 'bad password'
      click_button 'Log In'

      expect(page).to have_content('Your email or password was incorrect!')
      expect(page).to have_button('Log In')
    end
  end

  describe 'A logged in user can log out' do
    before :each do
      @user = User.create!(name: 'Morgan', email: 'morgan@example.com', password: 'securepassword', password_confirmation: 'securepassword')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'I visit the log out path' do
      visit '/images'

      within 'nav' do
        click_link 'Log Out'
      end

      expect(current_path).to eq(root_path)
      expect(page).to_not have_content("Logged in as #{@user.name}")
      expect(page).to have_content('You have been logged out!')
    end
  end
end
