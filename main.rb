require 'rubygems'
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'imdb'

get '/' do
  f = File.new('movies.csv', 'r')

  erb :index
end


get '/new_movie' do

  erb :new_movie
end

post '/new_movie' do

  my_new_movie = Imdb::Search.new("Jobs").movies.first
  @title = my_new_movie.title
  @year = my_new_movie.year
  @release_date = my_new_movie.release_date
  @director = my_new_movie.director
  @image = my_new_movie.poster
  @genres = my_new_movie.genres
  @length = my_new_movie.length
  @tagline = my_new_movie.tagline

  f = File.new('movies.csv', 'a+')

  @movie = params[:name]
  redirect to('/')
end