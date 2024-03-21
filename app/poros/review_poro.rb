class ReviewPoro 
  attr_reader :id, :author, :username, :rating, :author_details, :content, :created_at, :updated_at, :url
  def initialize(attributes)
    @id = attributes[:id]
    @author = attributes[:author]
    @username = attributes[:author_details][:username]
    @rating = attributes[:author_details][:rating]
    @author_details = attributes[:author_details]
    @content = attributes[:content]
    @created_at = attributes[:created_at]
    @updated_at = attributes[:updated_at]
    @url = attributes[:url]
  end
end