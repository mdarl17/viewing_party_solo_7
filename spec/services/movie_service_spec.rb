require "rails_helper" 

RSpec.describe MovieService, :vcr do 
  before(:each) do 
    @service = MovieService.new
  end

  it "exists" do 
    expect(@service).to be_a MovieService
  end

  describe "methods" do 
    describe "#get_top_movies" do 
      it "has a method that returns TMDB's top movies" do 
        top_movies = @service.get_top_movies[:results]

        expect(top_movies[0][:original_title]).to eq("The Shawshank Redemption")
        expect(top_movies[0][:vote_average]).to eq(8.704)

        expect(top_movies[1][:original_title]).to eq("The Godfather")
        expect(top_movies[1][:vote_average]).to eq(8.695)

        expect(top_movies[2][:original_title]).to eq("The Godfather Part II")
        expect(top_movies[2][:vote_average]).to eq(8.576)
      end
    end

    describe "#movies_by_title" do 
      it "has a case-insensitive, partial-word search by movie title" do 
        search_result = @service.movies_by_title("Strange Brew")[:results]

        search_result[0][:original_title] = "Strange Brew"
        search_result[0][:vote_average] = 6.078
      end
    end

    describe "#get_url" do 
      it "has a method with a custom url parameter that returns parsed, symbolized response data from an external API" do 
        response_hash = @service.get_url("/3/search/movie?query=memento&include_adult=false&language=en-US&page=1")
        first_result = response_hash[:results][0]

        expect(first_result[:original_title]).to eq("Memento")
        expect(first_result[:vote_average]).to eq(8.185)
      end
    end

    describe "#connection" do 
      it "has a method that returns an external API connection object" do 
        connection = @service.conn

        expect(connection.headers[:Authorization]).to eq(Rails.application.credentials.TMDB[:key])
        expect(connection.url_prefix).to be_a URI::HTTPS
        expect(connection.url_prefix.to_s).to eq("https://api.themoviedb.org/")
      end
    end
  end
end 