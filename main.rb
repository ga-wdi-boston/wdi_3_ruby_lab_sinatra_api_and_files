require 'rubygems'
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'imdb'

get '/' do

  @movie_titles = []
  movie_file = File.new('movies.csv', 'r')
  movie_file.each do |line|
    @movie_titles << line.split(',')[0]
  end
  movie_file.close

  erb :movies
end

get '/movie/:title' do
  @title = params[:title]
  @img_link = ""
  movie_file = File.open('movies.csv', 'r')
  movie_file.each do |line|
    movie_info = line.split(',')
    if movie_info[0] == @title
      @img_link = movie_info[2]
      break
    end
  end
  movie_file.close

  erb :movie
end

get '/new_movie' do
  erb :new_movie
end

post '/new_movie' do
  @title = params[:title]
  @movie = Imdb::Search.new(@title).movies.first
  File.open('movies.csv', 'a+') do |file|
    file.puts("#{@movie.title}, #{@movie.year}, #{@movie.poster}")
  end
  @title = @movie.title
  @img_link = @movie.poster
  redirect to("/movie/#{URI::escape(@title)}")
end

