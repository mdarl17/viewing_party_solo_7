class MovieFacade
  def initialize
    @service = MovieService.new
  end

  def top_movies 
    top_movies = @service.get_top_movies[:results]
    convert_to_movie_poros(top_movies)
  end

  def keywords_search(keywords)
    response = @service.movies_by_title(keywords)
    search_results = response[:results]
    convert_to_movie_poros(search_results)
  end

  def find_movie_with_id(movie_id)
    search_result = @service.by_id(movie_id)
    convert_to_movie_poros([search_result])
  end

  def convert_to_movie_poros(results)
    results.map do |movie|
      MoviePoro.new(movie)
    end
  end
end