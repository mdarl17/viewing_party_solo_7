require "rails_helper"

RSpec.describe "a user searches for movies", :vcr, type: :feature do 
  describe "When user visits '/users/:id/discover'" do 
    before(:each) do 
      @user = User.create!(name: 'Tommy', email: 'tommy@email.com')
      visit search_movies_path(@user.id)
    end

    it "they see a button to discover 'Top Rated Movies'" do
      expect(page).to have_button("Find Top Rated Movies")

      click_button "Find Top Rated Movies"

      expect(current_path).to eq(movies_results_path(@user.id))
    end

    it "they see a field to search movie titles by keyword" do 
      expect(page).to have_field(:keywords)
      expect(page).to have_button("Find Movies")

      click_button "Find Movies"

      expect(current_path).to eq(movies_results_path(@user.id))
    end
  end
end