require 'rubygems'
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'imdb'

get '/' do
  f = File.new("movies.csv", "r")
  @movies = []
  f.each do |line|
    if line
      @movies << line
    end
  end
  erb :index
end

get '/movie/:movie_name' do
end

# Use the first search result. Here I'm searching for the "Jobs" movie.
my_movie = Imdb::Search.new("Jobs").movies.first
puts my_movie.title
puts my_movie.poster
puts my_movie.year

#### Methods on an individual movie
#company
#genres (multiple)
#length
#director
#mpaa_rating
#plot_synopsis
#tagline
#year
#poster
#release_date