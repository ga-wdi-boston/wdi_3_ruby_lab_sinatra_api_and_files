require 'rubygems'
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'imdb'


# Function to prep movie information
def get_movies_hash
  movie_file = File.new('movies.csv', 'r')
  movies_hash = {}
  movie_file.each do |line|
    movie_array = line.split('|')
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
  @movies = get_movies_hash
  @company = @movies[@name][1]
  @genres = @movies[@name][2]
  @length = @movies[@name][3]
  @director = @movies[@name][4]
  @mpaa_rating = @movies[@name][5]
  @plot_synopsis = @movies[@name][6]
  @tagline = @movies[@name][7]
  @year = @movies[@name][8]
  @poster= @movies[@name][9]
  @release_date = @movies[@name][10]
  erb :movie
end

# This page should have a form to create a new movie, which will POST to /new_movie
get '/new_movie' do
  erb :new_movie
end

# Create a new movie by sending a POST request to this URL
post '/new_movie' do
  @title = params[:title]
  new_movie = Imdb::Search.new(@title).movies.first

  @movie_title = new_movie.title
  @company = new_movie.company
  @genres = new_movie.genres
  @length = new_movie.length
  @director = new_movie.director
  @mpaa_rating = new_movie.mpaa_rating
  @plot_synopsis = new_movie.plot_synopsis
  @tagline = new_movie.tagline
  @year = new_movie.year
  @poster= new_movie.poster
  @release_date = new_movie.release_date


  f = File.new('movies.csv', 'a+')
  f.puts("#{@movie_title}|#{@company}|#{@genres}|#{@length}|#{@director}|#{@mpaa_rating}|#{@plot_synopsis}|#{@tagline}|#{@year}|#{@poster}|#{@release_date}")
  f.close

  #This will send you to the newly created movie
  redirect to("/movie/#{URI::encode(@movie_title)}")
end



