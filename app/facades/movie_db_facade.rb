class MovieDbFacade
  def self.top_40
    endpoint = "/3/discover/movie?language=en&sort_by=popularity.desc"
    json = result_loop(40, endpoint)
  end

  def self.search(input)
    endpoint = "/3/search/movie/?query=#{input}"
    result_loop(40, endpoint)
  end

  def self.create_movie_instances(json)
    json.map do |movie|
      Movie.new(movie)
    end
  end

  def self.movie_details(movie_id)
    endpoint = "/3/movie/#{movie_id}"
    Movie.new(MovieDbService.get_data(endpoint))
  end

  def self.movie_actors(movie_id)
    endpoint="/3/movie/#{movie_id}/credits?"
    filter_crew(MovieDbService.get_data(endpoint)).map do |actor|
      Actor.new(actor)
    end
  end

  def self.movie_reviews(movie_id)
    endpoint="/3/movie/#{movie_id}/reviews?"
    MovieDbService.get_data(endpoint)[:results].map do |review|
      Review.new(review)
    end
  end

  def self.filter_crew(json)
    json[:cast].select do |actor|
      actor[:known_for_department] == 'Acting'
    end.first(10)
  end

  def self.result_loop(results_num, endpoint)
    page = 0
    json = []
    loop do
      page += 1
      endpoint = endpoint + "&page=#{page}"
      response = MovieDbService.get_data(endpoint)
      json << response[:results]
      break if json.flatten.length >= results_num || json.flatten.length == response[:total_results]
    end
    json.flatten
  end
end
