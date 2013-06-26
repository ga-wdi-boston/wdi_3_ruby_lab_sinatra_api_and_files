require 'rubygems'
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'imdb'


movie = Imdb::Search.new("title").movies.first

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
  erb :movie
end