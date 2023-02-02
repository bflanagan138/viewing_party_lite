class MoviesService < ApplicationRecord

  def search
    @movie = Faraday.new(url: "https://api.themoviedb.org/3/movie/76341?api_key=")
  
  
  end


end