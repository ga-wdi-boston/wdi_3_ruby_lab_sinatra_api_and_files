require 'rubygems'
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'imdb'

# This should list all the movies
get '/' do
  movie_file = File.new('movies.csv', 'r')
  @movies_hash = {}
  movie_file.each do |line|
    movie_array = line.split(',')
    title = movie_array[0]
    @movies_hash[title] = movie_array
  end
  movie_file.close
  erb :movies
end

