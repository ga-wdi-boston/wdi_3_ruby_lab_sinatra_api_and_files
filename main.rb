require 'rubygems'
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'imdb'



get '/new_movie' do
  @new_movie = params[:new_movie]
  movies_file = File.new("movies.csv", "a+")
  my_movie = Imdb::Search.new("Space Jam").movies.first

  film = []
  film << my_movie.title
  film << my_movie.poster
  film << my_movie.year
  movies_file << film
  movies_file.close
  erb :new_movie
end




      # my_movie = Imdb::Search.new(:name).movies.first

      # film = []

      # film << my_movie.title
      # film << my_movie.poster
      # film << my_movie.year
      # csv  << film


post '/new_movie' do


 erb :new_movie
end



get '/movie' do



 erb :movie
end




def movie_getter()
my_movie = Imdb::Search.new(name).movies.first
puts my_movie.title
puts my_movie.poster
puts my_movie.year
end
