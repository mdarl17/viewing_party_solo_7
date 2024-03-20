class MovieService
  def get_top_movies
    get_url("/3/movie/top_rated?language=en-US&page=1")
  end

  def movies_by_title(user_input)
    get_url("/3/search/movie?query=#{user_input}&include_adult=false&language=en-US&page=1")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new("https://api.themoviedb.org") do |faraday| 
      faraday.headers["Authorization"] = Rails.application.credentials.TMDB[:key]
    end
  end
end