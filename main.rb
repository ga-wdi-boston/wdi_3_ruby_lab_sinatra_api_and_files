require 'rubygems'
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'imdb'

get '/' do
  f = File.new("movies.csv", "r")
  @movies = []
  f.each do |line|
    @movies << line.split('|') unless line.empty?
  end
  f.close
  erb :index
end

get '/add_movie' do
  erb :add_movie
end

post '/add_movie' do
  f = File.open('movies.csv', 'a+')
  @title = params[:title]
  @my_movie = Imdb::Search.new(@title).movies.first
  @title = @my_movie.title
  @director = @my_movie.director
  @image_link = @my_movie.poster
  f.puts("#{@title}|#{@director}|#{@image_link}")
  f.close
  erb :movie
end

get '/movie/:title' do
  @title = params[:title]
  @image_link = ""
  f = File.new("movies.csv", "r")
  f.each do |line|
    if line.split('|')[0] == @title
      @director = line.split('|')[1]
      @image_link = line.split('|')[2]
      break
    end
  end
  erb :movie
end

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