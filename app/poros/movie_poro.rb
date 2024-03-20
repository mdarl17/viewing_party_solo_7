class MoviePoro 
  attr_reader :title, :vote

  def initialize(movie_data)
    @title = movie_data[:original_title]
    @vote = movie_data[:vote_average]
  end
end