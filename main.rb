require 'rubygems'
require 'pry'
# require 'sinatra'
# require 'sinatra/reloader' if development?
require 'imdb'

def download_movie_info(title)
  # Fetch movie data from IMBD per the title entered.
  raw_movie_data = Imdb::Search.new(title).movies.first

  # Organize the fetched movie data into hash
  hashed_movie_data = {}
  hashed_movie_data[:title] = raw_movie_data.title
  hashed_movie_data[:poster] = raw_movie_data.poster
  hashed_movie_data[:year] = raw_movie_data.year
  hashed_movie_data[:company] = raw_movie_data.company
  hashed_movie_data[:genres] = raw_movie_data.genres
  hashed_movie_data[:length] = raw_movie_data.length
  hashed_movie_data[:director] = raw_movie_data.director
  hashed_movie_data[:mpaa_rating] = raw_movie_data.mpaa_rating
  hashed_movie_data[:tagline] = raw_movie_data.tagline
  hashed_movie_data[:year] = raw_movie_data.year
  hashed_movie_data[:poster] = raw_movie_data.poster
  hashed_movie_data[:release_date] = raw_movie_data.release_date

  # Save the oranized hash into 'movies.csv' file for later access
  f = File.new('movies.csv', 'a+')
  f.puts(hashed_movie_data)
  f.close
end

def lookup_fav_movies
  f = File.new('movies.csv', 'r')
end

download_movie_info("jobs")
download_movie_info("inception")

# get '/' do
#   erb :favlist
# end

# post '/' do
# end


# get '/movie/:favorite' do
# end



