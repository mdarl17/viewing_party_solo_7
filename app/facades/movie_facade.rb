class MovieFacade
  def initialize(top_movies: false, keywords: nil, movie_id: nil)
    @top_movies = top_movies
    @keywords = keywords
    @movie_id = movie_id
  end

  include PoroFactory

  def movies
    if @top_movies
      @service = MovieService.new
      movie_data = @service.get_top_movies[:results]
      movies = make_movie_poros(movie_data)
    elsif @keywords
      @service = MovieService.new
      search_results = @service.get_movies_by_title(@keywords)
      movie_data = search_results[:results]
      make_movie_poros(movie_data)
    elsif @movie_id
      @service = MovieService.new
      movie_data = @service.get_movies_by_id(@movie_id)
      make_movie_poros(movie_data)
    else
      nil
    end
  end
end