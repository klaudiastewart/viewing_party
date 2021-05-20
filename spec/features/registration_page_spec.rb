require 'rails_helper'

RSpec.describe 'Registration', type: :feature do
  describe 'Registration Page' do
    it "I can create a new user and save that user to the db" do
      visit root_path

      click_link "New to Viewing Party? Register Here"

      expect(current_path).to eq("/register")

      fill_in 'user[email]', with: "klaw@test.com"
      fill_in 'user[password]', with: "test123"
      fill_in 'user[password_confirmation]', with: "test123"

      click_button "Register"

      expect(current_path).to eq(dashboard_index_path)
      new_user = User.last

      expect(page).to have_content("Welcome, klaw@test.com!")
    end

    it "I cannot create a new user if the password and password confirmation are not the same" do
      visit root_path

      click_link "New to Viewing Party? Register Here"

      expect(current_path).to eq("/register")

      fill_in 'user[email]', with: "clock@test.com"
      fill_in 'user[password]', with: "test1234"
      fill_in 'user[password_confirmation]', with: "test"

      click_button "Register"

      expect(page).to have_content("Register")
      expect(page).to have_content("Please make sure the passwords match")
    end
  end
end
