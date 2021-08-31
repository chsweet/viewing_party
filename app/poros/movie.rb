class Movie
  attr_reader :title,
              :vote_average,
              :runtime,
              :genres,
              :summary,
              :id

  def initialize(data)
    @id = data[:id]
    @title = data[:original_title]
    @vote_average = data[:vote_average]
    @runtime = data[:runtime]
    @genres = data[:genres]
    @summary = data[:overview]
  end

  def genre_names
    @genres.map do |data|
      data[:name]
    end
  end

  def hours
    @runtime / 60
  end

  def minutes
    @runtime % 60
  end
end
