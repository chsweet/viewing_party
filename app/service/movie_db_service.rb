class MovieDbService
  def top_40
    endpoint = "https://api.themoviedb.org/3/discover/movie?api_key=bf577430a36611e1e70e3fd900b3d9ba&language=en&sort_by=popularity.desc"
    result_loop(40, endpoint)
  end

  def search(input)
    endpoint = "https://api.themoviedb.org/3/search/movie/?api_key=bf577430a36611e1e70e3fd900b3d9ba&query=#{input}"
    get_data(endpoint)
  end

  def get_data(endpoint)
    response = Faraday.get(endpoint)
    JSON.parse(response.body, symbolize_names: true)
  end

  def result_loop(results_num, endpoint)
    page = 0
    json = []
    #change loop. need to include total results calculation
    until json.flatten.length >= results_num
      page += 1
      endpoint = endpoint + "&page=#{page}"
      # require "pry";binding.pry
      json << get_data(endpoint)[:results]
    end
    json.flatten
  end
end
