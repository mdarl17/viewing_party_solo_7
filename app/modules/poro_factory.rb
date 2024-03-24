module PoroFactory
	def make_movie_poros(attributes)
		if attributes.class == Hash 
      MoviePoro.new(attributes)
    else
      poros = attributes.map do |movie|
        MoviePoro.new(movie)
      end
    end
	end

	def cast_poros(attributes)
		attributes.map do |movie|
      CastPoro.new(movie)
    end
	end

	def review_poros(attributes)
		attributes.map do |review|
      ReviewPoro.new(review)
    end
	end
end