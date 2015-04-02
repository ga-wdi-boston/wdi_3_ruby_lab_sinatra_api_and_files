require 'rubygems'
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'imdb'

#Lists all movies
get '/movies' do
  list_file = File.new('movies.csv', 'r')
  @movies_list = []
  list_file.each do |movie|
    @movies_list << movie.split('|')
  end
  list_file.close
  erb :index
end

#Movie-specific page
get '/movie/:title' do
  @title = params[:title]
  @details = []
  list_file = File.new('movies.csv', 'r')
  list_file.each do |movie|
    if movie.split('|')[0] == @title then
      @details = movie.split('|')
  end
end
  erb :movie
end

# This page creates a form to search for a new movie
get '/movie_query' do
  erb :movie_query
end

# Pulls new-movie data from IMDB API, inserts into movies.csv
post '/movie_query' do
  f = File.new('movies.csv', 'a+')
  @title = params[:title]
  my_movie = Imdb::Search.new(@title).movies.first
  @title = my_movie.title
  @tagline = my_movie.tagline
  @director = my_movie.director
  @year = my_movie.year
  @company = my_movie.company
  @mpaa_rating = my_movie.mpaa_rating
  @poster = my_movie.poster
  f.puts("#{@title}|#{@tagline}|#{@director}|#{@year}|#{@company}|#{@mpaa_rating}|#{@poster}")
  f.close
  redirect to("/movie/#{URI::encode(@title)}")
end

#Ability to access static HTML about page
get '/' do
  redirect 'about.html'
end