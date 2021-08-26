class MovieDbService
  def top_40
    endpoint = 'https://api.themoviedb.org/3/discover/movie?api_key=bf577430a36611e1e70e3fd900b3d9ba&language=en&sort_by=popularity.desc'
    get_data(endpoint)
  end

  def search(input)
    endpoint = "https://api.themoviedb.org/3/search/movie/?api_key=bf577430a36611e1e70e3fd900b3d9ba&query=#{input}"
    get_data(endpoint)
  end

  def get_data
    response = Faraday.get(endpoint)
    JSON.parse(response.body, symbolize_names: true)
  end
end
