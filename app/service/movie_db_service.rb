class MovieDbService
  def self.get_data(endpoint)
    conn = Faraday.new(url: "https://api.themoviedb.org/") do |faraday|
      # faraday.use FaradayMiddleware::FollowRedirects, limit: 5
      # faraday.adapter Faraday.default_adapter
      faraday.params['api_key'] = ENV['movie_api_key']
    end
    response = conn.get(endpoint)
    JSON.parse(response.body, symbolize_names: true)
  end


end
