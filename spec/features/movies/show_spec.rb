require "rails_helper"

RSpec.describe "Movie Details Page", :vcr, type: :feature do 
  before(:each) do 
    @user = User.create!(name: 'Tommy', email: 'tommy@email.com')
    @movie_id = 264660
    @facade = MovieFacade.new
    visit movie_details_path(id: @user.id, movie_id: @movie_id)
  end

  it "has a button to create a Viewing Parth" do 
    expect(page).to have_button("Create a Viewing Party")
    expect(page).to have_button("Discover")
  end

  it "displays attributes of a movie; including title, genres, summary, cast, and review info." do 
    apis_aggregated = @facade.aggregate_movie_show_data(@movie_id)
    movie_data = apis_aggregated[:movie]
    cast_data = apis_aggregated[:cast]
    review_data = apis_aggregated[:reviews]

    expect(page).to have_content(movie_data.title)
    expect(page).to have_content("Vote Average: #{movie_data.vote}")
    expect(page).to have_content("Genres: #{movie_data.genres.join(", ")}")
    expect(page).to have_content("Runtime: #{movie_data.runtime}")
    expect(page).to have_content("Summary: #{movie_data.summary}")
    expect(page).to have_content("Cast")
    
    cast_data.each do |member| 
      expect(page).to have_content("#{member.character}: #{member.actor}")
    end

    expect(page).to have_content("#{review_data[:count]} Reviews")

    review_data[:review_info].each.with_index do |review, idx| 
      expect(page).to have_content("Reviewer: #{review.author}")
      expect(page).to have_content("Username: #{review.username}")
      expect(page).to have_content("Reviewer Rating: #{review.rating}")
      expect(page).to have_link(review.url)
      # TODO Why won't this work??
      # Questions to help resolve continuing RSpec/Capybara errors when testing strings
      # expect(page).to have_content(review.content)
    end
  end
end 