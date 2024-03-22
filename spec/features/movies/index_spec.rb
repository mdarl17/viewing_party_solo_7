require "rails_helper" 

RSpec.describe "Movies Results Page", :vcr, type: :feature do 
  before(:each) do 
    @user = User.create!(name: 'Tommy', email: 'tommy@email.com')
    visit discover_path(@user.id)
  end

  describe "two ways a user searches for movies" do 
    it "they can click the `Find Top Rated Movies` button" do 
      click_button("Find Top Rated Movies")

      expect(current_path).to eq(movies_results_path(@user.id))
      expect(page).to have_content("Search Results")
      expect(page.status_code).to eq 200
      expect(page).to have_content("The Shawshank Redemption")
    end

    it "a user can do a case-insensitive, partial match search for movie titles" do 
      fill_in(:keywords, with: "Strange")
      click_button "Find Movies"

      expect(current_path).to eq(movies_results_path(@user.id))
      
      page.all(".movies").map.with_index do |movie_el, idx|
        within("#results-#{idx}") do 
          expect(page.body.downcase).to include("strange")
        end
      end
    end
  end

  it "has a button to return to the Discover page" do 
    click_button("Find Top Rated Movies")
    expect(page).to have_button("Discover")
    
    click_button "Discover"
    expect(current_path).to eq(discover_path(@user.id))
  end
end 