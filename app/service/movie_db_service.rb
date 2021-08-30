class MovieDbService
  def top_40
    endpoint = "/3/discover/movie?language=en&sort_by=popularity.desc"
    result_loop(40, endpoint)
  end

  def search(input)
    endpoint = "/3/search/movie/?query=#{input}"
    result_loop(40, endpoint)
  end

  def movie_details(movie_id)
    endpoint = "/3/movie/#{movie_id}"
    get_data(endpoint)
  end

  def movie_actors(movie_id)
    endpoint="/3/movie/#{movie_id}/credits?"
    get_data(endpoint)
  end

  def movie_reviews(movie_id)
    endpoint="/3/movie/#{movie_id}/reviews?"
    get_data(endpoint)
  end

  def get_data(endpoint)
    conn = Faraday.new(url: "https://api.themoviedb.org/") do |faraday|
      faraday.use FaradayMiddleware::FollowRedirects, limit: 5
      faraday.adapter Faraday.default_adapter
      faraday.params['api_key'] = ENV['movie_api_key']
    end
    response = conn.get(endpoint)
    JSON.parse(response.body, symbolize_names: true)
  end

  def result_loop(results_num, endpoint)
    page = 0
    json = []
    #change loop. need to include total results calculation
    loop do
      page += 1
      endpoint = endpoint + "&page=#{page}"
      response = get_data(endpoint)
      json << response[:results]
      break if json.flatten.length >= results_num || json.flatten.length == response[:total_results]
    end
    json.flatten
  end
end
