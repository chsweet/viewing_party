class MovieDbService
  def self.get_data(endpoint)
    conn = Faraday.new(url: 'http://api.themoviedb.org/') do |faraday|
      faraday.params['api_key'] = ENV['movie_api_key']
    end
    response = conn.get(endpoint)
    JSON.parse(response.body, symbolize_names: true)
  end
end
