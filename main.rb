require 'rubygems'
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'imdb'

# Method to fetch IBMD data and save into local movies.csv file
def download_movie_info(title)
  # Fetch movie data from IMBD per the title entered.
  raw_movie_data = Imdb::Search.new(title).movies.first

  # Organize the fetched movie data into array
  array_movie_data = []
  array_movie_data << raw_movie_data.title << raw_movie_data.year << raw_movie_data.company << raw_movie_data.genres.join(", ").to_s << raw_movie_data.length << raw_movie_data.director << raw_movie_data.mpaa_rating << raw_movie_data.tagline << raw_movie_data.poster << raw_movie_data.release_date

  # Save the array into 'movies.csv' file as pipe-separated data for later access
  f = File.new('movies.csv', 'a+')
  f.puts(array_movie_data.join("|"))
  f.close
  return array_movie_data
end

# Method to access the saved movies.csv file
def access_fav_movies_file
  # Access 'movies.csv' file to pull the saved favorite movie info;
  # And create a hash data set based on the existing list in the file
  f = File.new('movies.csv', 'r')

  # Parse the pipe-seperated data and organize them into one aggregated hash.
  saved_movie_info_set = {}
  f.each do |line|
    movie_info_array = line.split("|")
    movie_info_hash = {}

    movie_info_hash[:title]        = movie_info_array[0]
    movie_info_hash[:year]         = movie_info_array[1]
    movie_info_hash[:company]      = movie_info_array[2]
    movie_info_hash[:genres]       = movie_info_array[3]
    movie_info_hash[:length]       = movie_info_array[4]
    movie_info_hash[:director]     = movie_info_array[5]
    movie_info_hash[:mpaa_rating]  = movie_info_array[6]
    movie_info_hash[:tagline]      = movie_info_array[7]
    movie_info_hash[:poster]       = movie_info_array[8]
    movie_info_hash[:release_date] = movie_info_array[9]

    saved_movie_info_set[movie_info_array[0].split("(")[0].split.join.downcase] = movie_info_hash
  end
  f.close
  return saved_movie_info_set
end


get '/' do
  @movie_db_hash = access_fav_movies_file
  erb :favlist
end

post '/' do
  received_movie_info = download_movie_info(params[:movie_to_find])
  @fav_movie_url = received_movie_info[0].split("(")[0].split.join.downcase
  redirect to("/movie/#{@fav_movie_url}")
end

get '/movie/:favorite' do
  saved_movie_info_set = access_fav_movies_file
  @favorite_movie_data = saved_movie_info_set[params[:favorite]]
  erb :favmovie
end

get '/about' do
  erb :aboutpage
end




