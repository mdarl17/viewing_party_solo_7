require "rails_helper" 

RSpec.describe MovieIndexPoro do 
  it "exists" do 
    attrs = {
      original_title: "Shawshank Redemption",
      vote_average: 8.314
    }

    movie = MovieIndexPoro.new(attrs)

    expect(movie).to be_a MovieIndexPoro
    expect(movie.title).to eq("Shawshank Redemption")
    expect(movie.vote).to eq(8.314)
  end
end 