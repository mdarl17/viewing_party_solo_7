require "rails_helper"

RSpec.describe "a user searches for movies", :vcr, type: :feature do
  describe "When user visits '/users/:id/movies'" do 
    before(:each) do 
      @user = User.create!(name: 'Tommy', email: 'tommy@email.com', id: 1)
      visit discover_path(@user.id)
    end
    it "they see a button to discover 'Top Rated Movies'" do
      # json_response = File.read("spec/fixtures/webmock/top_rated.json")
      # stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=1")
      # .with(
      #   headers: {
      #     'Authorization' => Rails.application.credentials.TMDB[:key]
      #   })
      # .to_return(status: 200, body: json_response, headers: {})
      click_button "Find Top Rated Movies"

      expect(current_path).to eq(movies_results_path(@user.id))
      expect(page).to have_content("Search Results")
    end

    it "they see a field to search movie titles by keyword", :vcr do 
      expect(page).to have_field(:keywords)
      fill_in(:keywords, with: "Strange Brew")
    
      click_button "Find Movies"
    
      expect(current_path).to eq(movies_results_path(@user.id))
    end
  end
end