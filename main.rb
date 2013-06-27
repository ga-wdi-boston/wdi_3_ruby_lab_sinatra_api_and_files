require 'rubygems'
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'imdb'


get '/' do
  list_of_favorite_movies = File.new('movies.csv', 'r')
  @movies = []
  list_of_favorite_movies.each do |line|
    @movies << line.split('|')
  end
  erb :home
end

get '/movies/:title' do
@title = params[:title]
list_of_favorite_movies = File.new('movies.csv', 'r')
@movie_info_array = []
  list_of_favorite_movies.each do |line|
    if line.split('|')[0] == @title then
      @movie_info_array = line.split('|')
    end
  end
  list_of_favorite_movies.close
  erb :movie
end


get '/new_movie' do
  erb :input
end

post '/new_movie' do
  @title = params[:title]
  new_movie= Imdb::Search.new(@title).movies.first
  @company = new_movie.company
  @genres = new_movie.genres[0]
  @length = new_movie.length
  @director = new_movie.director[0]
  @mpaa_rating = new_movie.mpaa_rating
  @plot_synopsis = new_movie.plot_synopsis
  @tagline = new_movie.tagline
  @year = new_movie.year
  @poster = new_movie.poster
  @release_date = new_movie.release_date
  #erb :input
  new_movie = File.new('movies.csv', 'a+')
  new_movie.puts("#{@title}|#{@year}|#{@director}|#{@tagline}|#{@poster}")
  new_movie.close
  redirect to("/")
end
