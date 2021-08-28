class Movie
  attr_reader :title,
              :vote_average,
              :runtime,
              :genres,
              :summary,
              :cast,
              :reviews,
              :id
  def initialize(data)
    @id = data[:id]
    @title = data[:original_title]
    @vote_average = data[:vote_average]
    #convert to hours and minutes
    @runtime = data[:runtime]
    @genres = genre_names(data[:genres])
    @summary = data[:overview]
    @cast = []
    @reviews = []

  end

  def genre_names(data_array)
    data_array.map do |data|
      data[:name]
    end
  end

  def hours
    @runtime/60
  end

  def minutes
    @runtime % 60
  end
end
