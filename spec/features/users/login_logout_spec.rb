require 'rails_helper'

RSpec.describe 'User Login and Log Out' do
  describe 'A registered user can log in' do
    describe 'As a default user' do
      before :each do
        @user = User.create(name: 'Morgan', email: 'morgan@example.com', password: 'securepassword')
      end

      it 'with correct credentials' do
        visit login_path

        fill_in 'Email', with: @user.email
        fill_in 'Password', with: @user.password
        click_button 'Log In'

        expect(current_path).to eq('/images')
        expect(page).to have_content("Logged in as #{@user.name}")
      end

    end
  end
end
