require 'rails_helper'

RSpec.describe 'Authorization', type: :feature do
  describe 'Apps authoritzation' do
    it 'does not allow a user to access the dashboard if they are not logged in' do
      visit dashboard_index_path
      expect(current_path).to eq(root_path)
      expect(page).to have_content('You do not have access to that page, please log in.')
    end

    it 'does not allow a user to see the movies path if they are not logged in' do
      visit movies_path
      expect(current_path).to eq(root_path)
      expect(page).to have_content('You do not have access to that page, please log in.')
    end

    it 'does not allow a user to see the parties path if they are not logged in' do
      visit parties_path
      expect(current_path).to eq(root_path)
      expect(page).to have_content('You do not have access to that page, please log in.')
    end
  end
end
