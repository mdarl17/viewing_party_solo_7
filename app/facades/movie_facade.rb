class MovieFacade
  def initialize
    @service = service = MovieService.new
  end

  def top_movies 
    top_movies = @service.get_top_movies[:results]
    convert_to_movie_poros(top_movies)
  end

  def keywords_search(keywords)
    response = @service.movies_by_title(keywords)
    poros = convert_to_movie_poros(response[:results])
    poros
  end

  def convert_to_movie_poros(results)
    results.map do |movie|
      MoviePoro.new(movie)
    end
  end
end