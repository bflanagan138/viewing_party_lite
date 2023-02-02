class Movie
  attr_reader :title,
              :vote_average,
              :genre_ids,
              :overview


  def initialize(attributes)
    @title        = attributes[:title]
    @vote_average = attributes[:vote_average]
    @genre_ids    = attributes[:genre_ids]
    @overview     = attributes[:overview]
  end
end
