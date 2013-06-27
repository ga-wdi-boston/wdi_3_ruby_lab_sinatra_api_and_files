require 'rubygems'
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'imdb'

def get_movie_hash()
  movie_file = File.new('movies.csv', "r")
  #title as the key
  movies = {}
  # iterates over each line
  movie_file.each do |line_in_file|
    # split each of those lines
    movie_data = line_in_file.split(',')
    # title is first element of array
    title = movie_data[0]
    movies[title] = movie_data
  end
  movie_file.close
  return movies
end


get '/' do
  @movies = get_movie_hash
  erb :movies
end

get '/movie/:name' do
  @name = params[:name]
  movie_file = File.new('movies.csv', 'r')
  @movie_info = []
  movie_file.each do |line|
    if line.split(',')[0] == @name
      @movie_info = line.split(',')
    end
  end
  movie_file.close
  erb :movie
end

get '/new_movie' do
  @name = params[:name]
  @movies = get_movie_hash
  @movie = @movies[@name]
  erb :new_movie
end

# Create a new movie by sending a POST request to this URL
post '/new_movie' do
    @title = params[:title]
    # @result = if @title
      @my_movie = Imdb::Search.new(@title).movies.first
      f = File.new('movies.csv', 'a+')
      f.puts("#{@title},#{@my_movie.year},#{@my_movie.director},#{@my_movie.poster},#{@my_movie.tagline}")
      f.close

  #This will send you to the newly created movie
  redirect to("/movie/#{@title}")
end