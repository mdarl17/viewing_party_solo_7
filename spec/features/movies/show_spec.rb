require "rails_helper"

RSpec.describe "Movie Details Page", :vcr, type: :feature do 
  before(:each) do 
    @user = User.create!(name: 'Tommy', email: 'tommy@email.com')
    @movie_id = 264660
  end

  it "has a button to create a Viewing Parth" do 
    visit movie_details_path(id: @user.id, movie_id: @movie_id)
    save_and_open_page
    expect(page).to have_button("Create a Viewing Party")
    expect(page).to have_button("Return to Discover")
  end
end 