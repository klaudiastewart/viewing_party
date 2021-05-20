require 'rails_helper'

RSpec.describe 'New Viewing Party Page', type: :feature do
  before(:each) do
    @user = User.create!(email: "ClaSte@hotmail.com", password: "1234", password_confirmation: "1234" )
    @user_2 = User.create!(email: "klaud", password: "1234", password_confirmation: "1234" )
    @user_3 = User.create!(email: "catdog", password: "1234", password_confirmation: "1234" )
    UserFriend.create(user_id: @user.id, friend_id: @user_2.id)
    UserFriend.create(user_id: @user.id, friend_id: @user_3.id)

    login(@user)
    @movie = MovieService.return_single_movie(123)
    visit "/movies/123"
    click_button "Create Viewing Party For Movie"
  end

  describe 'A new viewing party' do
    it 'I should see the name of the movie before the form' do
      expect(page).to have_content(@movie[:original_title])
      expect(page).to have_content("The Lord of the Rings")
    end

    it 'displays the runtime of the movie in the duration field' do
      expect(find_field('length').value).to eq "#{@movie[:runtime]}"
      expect(find_field('length').value).to eq "132"
    end

    it 'if my duration selected is less than the movie runtime, I cannot make the party and stay on the new page' do
      fill_in :length, with: 19
      click_button "Create Party"
      expect(current_path).to eq("/parties/new")
    end

    it 'shows a field for duration, when the party is, start time, and my friends that I can invite' do
      expect(page).to have_field(:length)
      expect(page).to have_field(:date_of_party)
      expect(page).to have_field(:time_of_party)
      expect(page).to have_content("Invite Friends")
    end

    it 'has checkboxes next to each friend' do
      find(:css, "#friends_#{@user_2.id}")
      find(:css, "#friends_#{@user_3.id}")
    end
  end

  describe 'I can fill out a form and make a new party' do
    it 'I can fill out the form' do
      @time_now = Time.now
      allow(Time).to receive(:now).and_return(@time_now)

      fill_in :length, with: 132
      fill_in :date_of_party, with: Date.tomorrow
      fill_in :time_of_party, with: @time_now
      find(:css, "#friends_#{@user_2.id}").set(true)
      find(:css, "#friends_#{@user_3.id}").set(true)

      click_button "Create Party"

      expect(current_path).to eq(dashboard_index_path)

      within('#party_card') do
        expect(page).to have_content("#{@movie[:original_title]}")
        expect(page).to have_content("#{@movie[:runtime]} minutes")
        expect(page).to have_content("Date: #{Date.tomorrow.strftime("%m/%d/%Y")}")
        expect(page).to have_content("Time: #{Time.now.strftime("%H:%M")} UTC")
      end
    end

    it 'I can click on a movie title on the dashboard page for a party I created and go to the movie show page' do
      @time_now = Time.now
      allow(Time).to receive(:now).and_return(@time_now)

      fill_in :length, with: 132
      fill_in :date_of_party, with: Date.tomorrow
      fill_in :time_of_party, with: @time_now
      find(:css, "#friends_#{@user_2.id}").set(true)
      find(:css, "#friends_#{@user_3.id}").set(true)

      click_button "Create Party"

      expect(current_path).to eq(dashboard_index_path)

      expect(page).to have_link("The Lord of the Rings")
      click_link "The Lord of the Rings"

      expect(current_path).to eq("/movies/#{@movie[:id]}")
    end
  end
end
