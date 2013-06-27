require 'rubygems'
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'imdb'



get '/new_movie' do
      @new_movie = params[:new_movie]
      movies_file = File.new("movies.csv", "a+")
      my_movie = Imdb::Search.new("Braveheart").movies.first
      @title = my_movie.title
      @poster = my_movie.poster
      @year = my_movie.year
      movies_file.puts("#{@title}| #{@year} | #{@poster}")
      movies_file.close
      erb :new_movie
    end



get '/new_movie' do

 erb :new_movie
end

post '/new_movie' do
  @title = params[:title]
  @movie = Imdb::Search.new(@title).movies.first
  File.new("movies.csv", "a+") do |movie_info|
  movie_info.puts("")
  erb :movie
end


get '/movies' do
  movies_file = File.new('movies.csv', 'r')
  @movies = []
  movies_file.each do |movie|
  @movies << movie.split(',')[0]
  end
  movies_file.close
  erb :movies
end

get '/movie/:name' do

end



  # redirect to("/movies/#{@title}")

# def movie_getter()
# my_movie = Imdb::Search.new(name).movies.first
# puts my_movie.title
# puts my_movie.poster
# puts my_movie.year
# end

  # film = []
  # film << my_movie.title
  # film << my_movie.poster
  # film << my_movie.year
  # movies_file << film
