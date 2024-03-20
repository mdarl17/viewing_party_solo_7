require "rails_helper" 

RSpec.describe "Movies Results Page", :vcr, type: :feature do 
  describe "two ways a user searches for movies" do 
    before(:each) do 
      @user = User.create!(name: 'Tommy', email: 'tommy@email.com')
      visit search_movies_path(@user.id)
    end
    
    it "they can click the `Find Top Rated Movies` button" do 
      click_button("Find Top Rated Movies")
      expect(current_path).to eq(movies_results_path(@user.id))
      expect(page).to have_content("Search Results")
      expect(page.status_code).to eq 200
      expect(page).to have_content("The Shawshank Redemption")
    end
  end
end 