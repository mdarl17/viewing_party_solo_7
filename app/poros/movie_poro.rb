class MoviePoro 
  attr_reader :id, :title, :vote, :runtime, :genres, :summary

  include PoroFactory
  include MovieHelpers

  def initialize(attributes=nil)
    @id = attributes[:id]
    @title = attributes[:title]
    @vote = attributes[:vote_average]
    @runtime = attributes[:runtime]
    @genres = attributes[:genres] ? parse_genres(attributes[:genres]) 
      : decode_genre_ids(attributes[:genre_ids])
    @summary = attributes[:overview]
  end

  def cast
    cast_data = get_cast(@id)
    cast_poros(cast_data)
  end

  def reviews 
    review_data = get_reviews(@id)
    rev_poros = review_poros(review_data)
    {count: rev_poros.count, rev_hash: rev_poros}
  end
end