class MovieIndexPoro 
  attr_reader :id, :title, :vote

  def initialize(attributes)
    @id = attributes[:id]
    @title = attributes[:original_title]
    @vote = attributes[:vote_average]
  end
end