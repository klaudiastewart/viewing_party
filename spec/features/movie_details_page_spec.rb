require 'rails_helper'

RSpec.describe 'Movie Details', type: :feature do
  before :each do
    user = User.create!(email: "ClaSte@hotmail.com", password: "1234", password_confirmation: "1234" )
    login(user)
  end

  describe 'single movie display' do
    it "As an authenticated user,
    When I visit the movies detail page,
    I should see:
    Button to create a viewing party
    Details This button should take the authenticated user to the new event page
    And I should see the following information about the movie:
    Movie Title
    Vote Average of the movie
    Runtime in hours & minutes
    Genre(s) associated to movie
    Summary description
    List the first 10 cast members (characters&actress/actors)
    Count of total reviews
    Each review's author and information" do
      VCR.use_cassette('movie_details_page') do
      visit "/movies/675"
      expect(page).to have_button("Create Viewing Party For Movie")
      expect(page).to have_content("Harry Potter and the Order of the Phoenix")
      expect(page).to have_content("138")
      expect(page).to have_content("Adventure | Fantasy | Mystery |")
      expect(page).to have_content("7.7")
      expect(page).to have_content("14804")
      expect(page).to have_content("Daniel Radcliffe.")
      expect(page).to have_content("John Chard")
      end
    end
  end
end
