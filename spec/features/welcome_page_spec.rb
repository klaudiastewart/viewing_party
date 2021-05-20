require 'rails_helper'

RSpec.describe 'Welcome Page', type: :feature do
  describe 'Weclome Page and Log In' do
    it "When a user visits the root path they should be on the welcome page which includes:
      Welcome message
      Brief description of the application
      Button to Log in
      Link to Registration
      (Details: Implement basic auth in the application allowing a user to log in with an email and password. The password should be stored in the database using bcrypt)." do
      user = User.create!(email: "ClaSte", password: "1234", password_confirmation: "1234" )
      visit root_path
      expect(page).to have_content("At Viewing Party, we make it easy to watch a movie with friends from the world.")
      expect(page).to have_link("New to Viewing Party? Register Here", href: "/register")
      fill_in :email, with: user.email
      fill_in :password, with: user.password
      expect(page).to have_button("Log In")
      click_on("Log In")
      expect(current_path).to eq("/dashboard")
      expect(page).to have_content("Welcome, #{user.email}!")
    end

    it 'will not login if the users password is wrong' do
      user = User.create!(email: "red", password: "1234", password_confirmation: "1234" )
      visit root_path
      fill_in :email, with: user.email
      fill_in :password, with: 1
      click_on("Log In")
      expect(current_path).to eq(root_path)
      expect(page).to have_content("Sorry, your credentials are bad.")
    end
  end
end
