require 'rubygems'
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'imdb'


get '/' do
    @movies = []
  movie_file = File.new("movies.csv", "r")
  movie_file.each do |line|
    @movies << line.split(',')

  end
erb :movies
end
