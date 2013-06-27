require 'rubygems'
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'imdb'

get '/' do
  f = File.new('movies.csv', 'r')
  @movies =[]
  f.each do |line|
    @movies << line.split('| ')
  end
  erb :index
end

get '/movie/:title' do
  @single_movie = params[:title]
  f = File.new('movies.csv', 'r')
  @movie_array = []

  f.each do |line|
    if line.split('| ')[0] == @single_movie
      @movie_array = line.split('| ')
    end
  end

  erb :movie
end

get '/new_movie' do
  erb :new_movie
end

post '/new_movie' do
  @name = params[:name]
  my_new_movie = Imdb::Search.new(@name).movies.first
  @title = my_new_movie.title
  @year = my_new_movie.year
  @release_date = my_new_movie.release_date
  @director = my_new_movie.director[0]
  @image = my_new_movie.poster
  @genres = my_new_movie.genres[0]
  @length = my_new_movie.length
  @tagline = my_new_movie.tagline

  f = File.new('movies.csv', 'a+')
  f.puts("#{@title}| #{@year}| #{@release_date}| #{@director}| #{@image}| #{@genres}| #{@length}| #{@tagline}")
  f.close

  redirect to('/')
end

get '/about' do

  erb :about
end