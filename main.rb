require 'rubygems'
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'imdb'


# Function to prep movie information
###remember to change split to |
def get_movies_hash
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
  @movies = get_movies_hash
  erb :movies
end

# This should show a single movie_array
get '/movie/:name' do
  @name = params[:name]
  erb :movie
end

# This page should have a form to create a new movie, which will POST to /new_movie
get '/new_movie' do
  erb :new_movie
end