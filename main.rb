require 'rubygems'
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'imdb'


# Function to prep movie information
###remember to change split to |
def get_movie_hash
  movie_file = File.new('movies.csv', 'r')
  movies_hash = {}
  movie_file.each do |line|
    movie_array = line.split(',')
    title = movie_array[0]
    movies_hash[title] = movie_array
  end
  movie_file.close
  return movies_hash
end


# This should list all the movies
get '/' do
  @movies = movies_hash
  erb :movies
end

# This should show a single movie_array
get '/movie/:name' do
  @name = params[:name]
  erb :movie
end

