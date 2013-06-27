require 'rubygems'
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'imdb'

get '/' do
  movie_file = File.new('movies.csv', 'r')
  @movies = []
  movie_file.each do |line|
    @movies << line.split(',')
  end
  movie_file.close
  erb :index
end

post '/' do
  @title = params[:title]
  movie_file = File.new('movies.csv', 'a+')
  @my_movie = Imdb::Search.new(@title).movies.first
  movie_file.puts("#{@my_movie.title[0..-8]},#{@my_movie.year},#{@my_movie.director[0]},#{@my_movie.poster}")
  movie_file.close
  redirect to ("/movie/#{URI::encode(@my_movie.title[0..-8])}")
end

get '/movie/:title' do
  @title = params[:title]
  # @title = params[:name]
  @movies = []
  movie_file = File.new('movies.csv', 'r')
  movie_file.each do |line|
      if line.split(",")[0] == @title then
        @movies = line.split(",")
      end
  end
  movie_file.close
   erb :movie
end

get '/about' do
  erb :about
end