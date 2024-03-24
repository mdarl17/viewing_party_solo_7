class MovieFacade
  def initialize
    @service = MovieService.new
    @top_movies = false
  end

  def aggregate_movie_data(movie_id)
    {
      movie: get_movie_data_with_id(movie_id), 
      cast: get_cast_with_movie_id(movie_id),
      reviews: get_reviews_with_movie_id(movie_id)
    }
  end

  def top_movies 
    top_movies = @service.get_top_movies[:results]
    create_movie_poros(top_movies)
  end

  def keywords_search(keywords)
    response = @service.movies_by_title(keywords)
    search_results = response[:results]
    create_movie_poros(search_results)
  end

  def get_movie_data_with_id(movie_id)
    movie = @service.by_id(movie_id)
    create_movie_poros(movie)
  end

  def get_cast_with_movie_id(movie_id) 
    cast = @service.get_cast(movie_id)[:cast]
    create_cast_poro(cast)
  end

  def get_reviews_with_movie_id(movie_id) 
    reviews = @service.get_reviews(movie_id)[:results]
    review_poros = create_review_poros(reviews)
    {count: review_poros.count, review_info: review_poros}
  end

  def create_movie_poros(attributes)
    if attributes.class == Hash 
      MoviePoro.new(attributes)
    else
      poros = attributes.map do |movie|
        MoviePoro.new(movie)
      end
    end
  end

  def create_cast_poro(attributes)
    attributes.map do |movie|
      CastPoro.new(movie)
    end
  end

  def create_review_poros(attributes) 
    attributes.map do |review|
      ReviewPoro.new(review)
    end
  end
end