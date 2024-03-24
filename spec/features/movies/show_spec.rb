require "rails_helper"

RSpec.describe "Movie Details Page", :vcr, type: :feature do 
  before(:each) do 
    @user = User.create!(name: 'Tommy', email: 'tommy@email.com')
    @movie_id = 264660
    @facade = MovieFacade.new(top_movies: false, keywords: nil, movie_id: @movie_id)
    visit movie_details_path(id: @user.id, movie_id: @movie_id)
  end

  it "has a button to create a Viewing Parth" do 
    expect(page).to have_button("Create a Viewing Party")
    expect(page).to have_button("Discover")
  end

  it "displays attributes of a movie; including title, genres, summary, cast, and review info." do 
    expect(page).to have_content("Ex Machina")
    expect(page).to have_content("Vote Average: #{@facade.movies.vote}")
    expect(page).to have_content("Genres: #{@facade.movies.genres.join(", ")}")
    expect(page).to have_content("Runtime: #{@facade.movies.runtime}")
    expect(page).to have_content("#{@facade.movies.summary}")
    expect(page).to have_content("Cast")
    
    @facade.movies.cast.each do |member| 
      expect(page).to have_content("#{member.character}: #{member.actor}")
    end

    expect(page).to have_content("#{@facade.movies.reviews[:count]} Reviews")

    @facade.movies.reviews[:rev_hash].each.with_index do |review, idx| 
      expect(page).to have_content("Reviewer: #{review.author}")
      expect(page).to have_content("Username: #{review.username}")
      expect(page).to have_content("Reviewer Rating: #{review.rating}")
      expect(page).to have_link(review.url)
      # TODO Won't match text for formatting reasons??
      # expect(page).to have_content(review.content)
    end
  end
end 