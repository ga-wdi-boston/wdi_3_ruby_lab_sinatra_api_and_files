require 'rubygems'
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'imdb'


get '/' do
  @title = params[:title]
  #list of favorite movies from the file
  file = File.new("movies.csv", "r")
  @movie_list = []
  file.each do |movie|
    @movie_list << movie.split("|")
  end
  file.close


  #this is for the input form
  if @title
    movie = Imdb::Search.new(@title).movies.first
    @movie_title = movie.title
    @movie_company = movie.company

    file = File.new('movies.csv', "a+")
    file.puts("#{@movie_title}|#{@movie_company}")
    file.close
    redirect to("/movies/#{URI::encode(@movie_title)}")

  else
    ""
  end
  erb :root
end

get '/movies/:title' do
  @title = params[:title]
  erb :movie
end