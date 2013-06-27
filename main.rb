require 'rubygems'
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'imdb'

get '/' do
  movie_file = File.new('movies.csv', 'r')
  @movies = []
  movie_file.each do |line|
    @movies << line.split(',')
  end
  movie_file.close
  erb :index
end

post '/' do
  @title = params[:title]
  movie_file = File.new('movies.csv', 'a+')
  @my_movie = Imdb::Search.new(@title).movies.first
  movie_file.puts("#{@my_movie.title},#{@my_movie.year},#{@my_movie.director},#{@my_movie.poster}")
  movie_file.close
  redirect to ("/movie/#{URI::encode(@my_movie.title)}")
end

get '/movie/:title' do
  @title = params[:title]
  erb :movie
end