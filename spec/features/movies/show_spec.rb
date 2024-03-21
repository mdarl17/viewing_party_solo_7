require "rails_helper"

RSpec.describe "Movie Details Page", :vcr, type: :feature do 
  before(:each) do 
    @user = User.create!(name: 'Tommy', email: 'tommy@email.com')
    @movie_id = 264660
    visit movie_details_path(id: @user.id, movie_id: @movie_id)
  end

  it "has a button to create a Viewing Parth" do 
    expect(page).to have_button("Create a Viewing Party")
    expect(page).to have_button("Return to Discover")
  end

  it "displays attributes of a movie; including title, genres, summary, cast, and review info." do 
    expect(page).to have_content("Ex Machina")
    expect(page).to have_content("Vote Average: 7.573")
    expect(page).to have_content(108)
    expect(page).to have_content("Genres: Drama, Science Fiction")
    expect(page).to have_content("Summary: Caleb, a coder at the world's largest internet company, wins a competition to spend a week at a private mountain retreat belonging to Nathan, the reclusive CEO of the company. But when Caleb arrives at the remote location he finds that he will have to participate in a strange and fascinating experiment in which he must interact with the world's first true artificial intelligence, housed in the body of a beautiful robot girl.")
    expect(page).to have_content("Cast")
    expect(page).to have_content("Caleb Smith: Domhnall Gleeson")
    expect(page).to have_content("Ava: Alicia Vikander")
    expect(page).to have_content("Nathan Bateman: Oscar Isaac")
    expect(page).to have_content("Number of Reviews: 4")
    expect(page).to have_content("Reviewer: Andres Gomez")
    expect(page).to have_content("Reviewer: Andres Gomez")
    expect(page).to have_content("Username: tanty")
    expect(page).to have_content("Reviewer Rating: 8.0")
    expect(page).to have_link("https://www.themoviedb.org/review/56f08607c3a368718e000cd4")
  end
end 