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
    @runtime = data[:runtime]
    @genres = genre_names(data[:genres])
    @summary = data[:overview]
    @cast = []
    @reviews = []

  end

  def genre_names(array)

  end
end
