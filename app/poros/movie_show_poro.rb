class MovieShowPoro 
  attr_reader :id, :title, :vote, :runtime, :genres, :summary

  def initialize(attributes)
    @id = attributes[:id]
    @title = attributes[:original_title]
    @vote = attributes[:vote_average]
    @runtime = attributes[:runtime]
    @genres = parse_genres(attributes[:genres])
    @summary = attributes[:overview]
  end

  def parse_genres(genre_data)
    genre_data.map do |genre|
      genre[:name]
    end
  end
end