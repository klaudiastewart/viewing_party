class MovieService
  def self.conn
    puts 'HELLO WORLD'
    Faraday.new(
    url: "https://api.themoviedb.org",
    params: { api_key: ENV['MOVIE_TOKEN'] }
    )
  end

  def self.get_top_rated_movies
    #set up a counter here to funnel the movies into an array 
    page_1 = conn.get('/3/movie/top_rated?&page=1')
    page_2 = conn.get('/3/movie/top_rated?&page=2')

    page_1_json = JSON.parse(page_1.body, symbolize_names: true)
    page_2_json = JSON.parse(page_2.body, symbolize_names: true)
    movie_list = page_1_json[:results] + page_2_json[:results]
  end


  def self.list_movies_by_keyword(query)
    page_1= conn.get("/3/search/movie?query=#{query}")
    page_1_json = JSON.parse(page_1.body, symbolize_names: true)
    movie_list = page_1_json[:results]
  end

  def self.return_single_movie(id)
    selected_movie = conn.get("/3/movie/#{id}")
    JSON.parse(selected_movie.body, symbolize_names: true)
  end

  def self.return_single_movie_review(id)
    reviews = conn.get("/3/movie/#{id}/reviews")
    JSON.parse(reviews.body, symbolize_names: true)
  end
  def self.return_single_movie_cast(id)
    cast = conn.get("/3/movie/#{id}/credits")
    JSON.parse(cast.body, symbolize_names: true)
  end
end
