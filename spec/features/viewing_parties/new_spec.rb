require "rails_helper" 
require "support/test_data_helper"

RSpec.describe "New Viewing Party page", :vcr, type: :feature do 
  before(:each) do 
    @user = User.create!(name: 'Tommy', email: 'tommy@email.com')
    movie_details = TestDataHelper.movies_show_data(264660)
    @movie = movie_details[:movie]
    @cast = movie_details[:cast]
    @reviews = movie_details[:reviews]
  end
   describe "a user creates a new viewing party" do 
    it "has a form users can fill out and submit to make a new viewing party" do 
      visit new_viewing_party_path(user_id: @user.id, movie_id: @movie.id)

      expect(page).to have_content(@movie.title)
      expect(page).to have_content(@viewing_party.duration)
      expect(page).to have_content(@viewing_party.date)
      expect(page).to have_content(@viewing_party.start_time)
      expect(page).to have_field(:guest_1)
      expect(page).to have_field(:guest_2)
      expect(page).to have_field(:guest_3)
      expect(page).to have_button("Create Party")

      expect(current_path).to eq(viewing_party_dashboard_path)
    end
  end
end 