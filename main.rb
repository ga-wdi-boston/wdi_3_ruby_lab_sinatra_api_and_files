require 'rubygems'
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'imdb'


get '/' do
    @movies = []
  movie_file = File.new('movies.csv', 'r')
  movie_file.each do |line|
    @movies << line.split(',')
  end
erb :movies
end

get '/movie/:title' do
  @title = params[:title]

get '/new_movie' do
erb :new_movie
end

post '/new_movie' do
  @movie = Imdb::Search.new(@title).movies.first
erb :movie
end