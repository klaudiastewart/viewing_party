require 'rails_helper'

RSpec.describe 'Dashboard', type: :feature do
  before(:each) do
    @user = User.create!(email: "ClaSte@hotmail.com", password: "1234", password_confirmation: "1234" )
    login(@user)
  end

  describe 'Dashboard Page' do
    it 'I can see welcome username at the top of the page' do
      expect(current_path).to eq("/dashboard")
      expect(page).to have_content("Welcome, #{@user.email}!")
    end

    it "I can see and click a button to discover movies" do
      visit dashboard_index_path

      expect(page).to have_button("Discover Movies")

      click_button "Discover Movies"

      expect(current_path).to eq(discover_path)
    end

    it 'I can see a friends section' do
      visit dashboard_index_path

      expect(current_path).to eq(dashboard_index_path)
      expect(page).to have_content("Friends")
    end

    it 'I can see a viewing parties section' do
      visit dashboard_index_path

      expect(current_path).to eq(dashboard_index_path)
      expect(page).to have_content("Viewing Parties")
    end

    it 'can search for a friend and add them' do
      user_2 = User.create!(email: "email", password: "1234", password_confirmation: "1234" )

      fill_in :friend_search, with: "#{user_2.email}"
      click_button "Add friend"

      expect(page).to have_content(user_2.email)
      expect(@user.friends.count).to eq(1)
    end

    it 'says you currently have no friends if you have not added a friend yet' do
      expect(page).to have_content("You currently have no friends.")
    end

    it 'has a sad path message if a the email that is entered is not a user and the user does not add that frined' do
      visit dashboard_index_path

      friend = "non_existing_email"
      fill_in :friend_search, with: friend
      click_button "Add friend"

      expect(page).to have_content("#{friend} is not currently active with Viewing Party.")
      expect(@user.friends.count).to eq(0)
      expect(current_path).to eq(dashboard_index_path)
    end

    it 'can logout' do
      click_link "Log Out"
      expect(page).to_not eq(dashboard_index_path)
      expect(page).to have_content("You have been logged out.")
    end
  end
end
