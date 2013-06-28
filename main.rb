require 'rubygems'
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'imdb'

# This get route is supposed to take an put it info in the csv file
get '/new_movie' do
    @new_movie = params[:new_movie]
    movies_file = File.new("movies.csv", "a+")
    my_movie = Imdb::Search.new(@title).movies.first
    @title = my_movie.title
    @poster = my_movie.poster
    @year = my_movie.year
    movies_file.puts("#{@title}, #{@year}, #{@poster}")
    movies_file.close
    erb :new_movie
  end

# this posting route is supposed to set it to the pa
post '/new_movie' do
    @title = params[:title]
    @movie = Imdb::Search.new(@title).movies.first
    File.new("movies.csv", "a+") do |movie_info|
    movie_info.puts("#{@title} #{@year} #{@poster}")
    erb :movie
  end
end

# this will display all the movies in the catalog
get '/movies' do
  movies_file = File.new('movies.csv', 'r')
  @movies = []
  movies_file.each do |movie|
  @movies << movie.split(',')[0]
  end
  movies_file.close
  erb :movies
end

# this directs to the current movie page

get '/movie/:title' do
  @title = params[:title]
  @a_movie = []
  movies_file = File.new('movies.csv', 'r')
  movies_file.each do |title|
    if title.split(",")[0] == @title
      then @a_movie = title.split(',')
    end
  end
  erb :movie
end

# redirect to("/movies/#{@title}")




