require "rails_helper" 

RSpec.describe MoviePoro do 
  it "exists" do 
    attrs = {
      id: nil,
      title: "Shawshank Redemption",
      vote_average: 8.314,
      vote: nil,
      runtime: nil,
      genres: nil,
      summary: nil
    }

    movie = MoviePoro.new(attrs)
    expect(movie).to be_a MoviePoro
    expect(movie.title).to eq("Shawshank Redemption")
    expect(movie.vote).to eq(8.314)
  end
end 