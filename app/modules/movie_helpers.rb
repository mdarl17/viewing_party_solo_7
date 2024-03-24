module MovieHelpers
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

  def get_cast(movie_id) 
    service = MovieService.new
    service.get_cast(movie_id)[:cast][0..9]
  end

  def get_reviews(movie_id)
		service = MovieService.new
    service.get_reviews(movie_id)[:results]
  end
end