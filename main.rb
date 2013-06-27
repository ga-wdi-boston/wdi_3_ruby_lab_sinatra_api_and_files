require 'rubygems'
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'imdb'


get '/' do
  @title = params[:title]
  if @title
      redirect to("/movies/#{@title.gsub(/\s/,'-')}")
  else
    ""
  end
  erb :root
end

get '/movies/:title' do
  @title = params[:title]
  erb :movie
end

post '/' do
  @title = params[:title]
  movie = Imdb::Search.new(@title).movies.first
  movie_file = File.new("movies.csv", "a+")
  movie_file.puts(movie.title)
  redirect to("/movies/#{@title}")
  movie_file.close
end
