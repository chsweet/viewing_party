class MovieDbService
  def top_40
    endpoint = "https://api.themoviedb.org/3/discover/movie?api_key=bf577430a36611e1e70e3fd900b3d9ba&language=en&sort_by=popularity.desc"
    result_loop(40, endpoint)
  end

  def search(input)
    endpoint = "https://api.themoviedb.org/3/search/movie/?api_key=bf577430a36611e1e70e3fd900b3d9ba&query=#{input}"
    result_loop(40, endpoint)
  end

  def get_data(endpoint)
    response = Faraday.get(endpoint)
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
