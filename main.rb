require 'rubygems'
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'imdb'

# I want to populate the movie.csv file with info from Imdb
# This file should also be writable to add movies later
# I will then create a hash using the supplied methods as keys


get '/' do
end

#def my_movie_array()
  # Open the movies.csv file
  #File.New('movies.csv', 'a+'){ |outfile|
    CSV.open('movies.csv' 'ab') do  |csv|
      csv << ['jobs', 'company']
  end
  erb :movie_output
#end




  # create an empty hash
 # my_movie_hash = {}

#end













