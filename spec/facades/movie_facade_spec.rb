require "rails_helper"
require "support/test_data_helper.rb"

RSpec.describe MovieFacade, :vcr do 
  before(:each) do 
    @facade = MovieFacade.new
  end

  it "exists" do 
    expect(@facade).to be_a MovieFacade
  end

  describe "methods" do 
    describe "#top_movies" do 
      it "returns TMDB's top movies as an array of ruby objects with title and average vote attributes" do 
        top_movies = @facade.top_movies

        top_movies.each do |movie|
          expect(movie).to be_a MoviePoro
        end

        expect(top_movies[0].title).to eq("The Shawshank Redemption")
        expect(top_movies[0].vote).to eq(8.704)

        expect(top_movies[1].title).to eq("The Godfather")
        expect(top_movies[1].vote).to eq(8.695)

        expect(top_movies[2].title).to eq("The Godfather Part II")
        expect(top_movies[2].vote).to eq(8.576)
      end
    end

    describe "#keywords_search" do 
      it "returns a user's search results that case-insensitively and partially match, as ruby objects" do
        search_result = @facade.keywords_search("Strange Brew")

        search_result.each do |movie|
          expect(movie).to be_a MoviePoro
        end

        expect(search_result[0].title).to eq("Strange Brew")
        expect(search_result[0].vote).to eq(6.078)

        search_result = @facade.keywords_search("Strang")

        expect(search_result[0].title).to eq("Pirates of the Caribbean: On Stranger Tides")
        expect(search_result[0].vote).to eq(6.546)
      end
    end

    describe "#convert_to_movie_poros" do 
      it "given an array of movies with full data, it returns poros for each, with 'title' and 'vote' attributes" do 
        movies_full_data = TestDataHelper.movies_full_data
        movie_poros = @facade.convert_to_movie_poros(movies_full_data)

        movie_poros.each do |movie|
          expect(movie).to be_a MoviePoro
          expect(movie.public_methods(false).map(&:to_sym)).to match_array([:title, :vote])
        end
      end
    end
  end
end 