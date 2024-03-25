require "rails_helper"

RSpec.describe MovieFacade, :vcr do 
  it "exists" do 
    facade = MovieFacade.new(top_movies: true)
    expect(facade).to be_a MovieFacade
  end

  describe "methods" do 
    describe "#movies" do 
      it "returns TMDB's top movies as an array of ruby objects with title and average vote attributes" do 
        facade = MovieFacade.new(top_movies: true)
        top_movies = facade.movies

        top_movies.each do |movie|
          expect(movie).to be_a MoviePoro
        end

        expect(top_movies[0].id).to eq(278)
        expect(top_movies[0].title).to eq("The Shawshank Redemption")
        expect(top_movies[0].vote).to eq(8.705)

        expect(top_movies[1].id).to eq(238)
        expect(top_movies[1].title).to eq("The Godfather")
        expect(top_movies[1].vote).to eq(8.695)

        expect(top_movies[2].id).to eq(240)
        expect(top_movies[2].title).to eq("The Godfather Part II")
        expect(top_movies[2].vote).to eq(8.6)
      end
    end

    describe "#movies(keyword)" do 
      it "returns a user's search results that case-insensitively and partially match, as ruby objects" do
        facade = MovieFacade.new(keywords: "Strange Brew")

        facade.movies.each do |movie|
          expect(movie).to be_a MoviePoro
        end

        expect(facade.movies[0].title).to eq("Strange Brew")
        expect(facade.movies[0].vote).to eq(6.078)
      end

      it "returns a user's search results that case-insensitively and partially match, as ruby objects" do
        facade = MovieFacade.new(keywords: "StrANg")

        facade.movies.each do |movie|
          expect(movie.title.downcase).to include("strang")
          expect(movie).to be_a MoviePoro
        end
        
        expect(facade.movies[0].title).to eq("Pirates of the Caribbean: On Stranger Tides")
        expect(facade.movies[0].vote).to eq(6.546)
      end
    end

    describe "#movie(movie_id)" do 
      it "searches the movie database for movies with the provided id" do 
        facade =  MovieFacade.new(movie_id: 264660)
        expect(facade.movies).to be_a MoviePoro
        expect(facade.movies.id).to eq(264660)
        expect(facade.movies.title).to eq("Ex Machina")
        expect(facade.movies.vote).to eq(7.573)
      end
    end
  end
end 