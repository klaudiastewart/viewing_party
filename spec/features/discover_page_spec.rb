require 'rails_helper'

RSpec.describe 'Descover', type: :feature do
  before :each do
    user = User.create!(email: "ClaSte@hotmail.com", password: "1234", password_confirmation: "1234" )
    login(user)
  end

  describe 'Top 40' do
    it "As an authenticated user,
      When I visit the '/discover' path
      I should see :
      A Button to Discover top 40 movies
         When the user clicks on the top 40 button they should be taken to the movies page." do
        visit discover_path
        expect(page).to have_button("Discover Top 40 Movies")
        click_on("Discover Top 40 Movies")
        expect(current_path).to eq(movies_path)
      end

      it "As an authenticated user,
      When I visit the '/discover' path
      I should see :
      A text field to enter keyword(s) to search by movie title
      A Button to Search by Movie Title
      When the user clicks on the Search button they should be taken to the movies page." do
        visit discover_path
        expect(page).to have_content("Enter Keyword(s) To Search By Movie Title")
        fill_in :search_text, with: "Titanic"
        expect(page).to have_button("Find Movie")
        click_on("Find Movie")
        expect(current_path).to eq(movies_path)
    end
  end
end
