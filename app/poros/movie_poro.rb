class MoviePoro 
  attr_reader :id, :title, :vote, :runtime, :genres, :summary

  def initialize(attributes)
    @id = attributes[:id]
    @title = attributes[:title]
    @vote = attributes[:vote_average]
    @runtime = attributes[:runtime]
    # if search with movie_id => 
    @genres = attributes[:genres] ? parse_genres(attributes[:genres]) : decode_genre_ids(attributes[:genre_ids])
    @summary = attributes[:overview]
  end

  def decode_genre_ids(genre_ids) 
    return [] unless genre_ids
    genre_code_hashes = GenreDecoder.new.genre_hash[:genres]
    genre_code_hashes.reduce([]) do |genre_list, code_hash| 
      if genre_ids.include?(code_hash[:id])
        genre_list << code_hash[:name]
      end
      genre_list
    end
  end

  def parse_genres(genre_hash_array)
    genre_names = genre_hash_array.map do |genre_hash| 
      genre_hash[:name]
    end
  end
end