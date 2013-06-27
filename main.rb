require 'rubygems'
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'imdb'



get '/new_movie' do
  @new_movie = params[:new_movie]
  movies_file = File.new("movies.csv", "a+")
  my_movie = Imdb::Search.new("superman").movies.first

  film = []
  film << my_movie.title
  film << my_movie.poster
  film << my_movie.year
  movies_file << film

  movies_file.close
  erb :new_movie
end



post '/new_movie' do

 erb :new_movie
end



get '/movies' do
  movies_file = File.new('movies.csv', 'r')
  @movies = []
  movies_file.each do |movie|
    @movies << movie[0]
    @movies.flatten
  end
  movies_file.close
  erb :movies
end

get '/movie/:name' do

end

# def movie_getter()
# my_movie = Imdb::Search.new(name).movies.first
# puts my_movie.title
# puts my_movie.poster
# puts my_movie.year
# end
