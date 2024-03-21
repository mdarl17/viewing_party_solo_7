class MoviePoro 
  attr_reader :id, :title, :vote

  def initialize(movie_data)
    @id = movie_data[:id]
    @title = movie_data[:original_title]
    @vote = movie_data[:vote_average]
    @runtime = movie_data[:runtime]
    @genres = movie_data[:genres]
    @summary = movie_data[:overview]
    # TODO Cast will be diff url
    # TODO Reviews will be diff url
        # TODO Part of Reviews => :author, :author_details
  end
end