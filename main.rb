require 'rubygems'
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'imdb'

#Lists all movies
get '/' do
  list_file = File.new('movies.csv', 'r')
  @movies_list = []
  list_file.each do |movie|
    @movies_list << movie.split('|')
  end
  list_file.close
  erb :index
end

#Movie-specific page
get '/movie/:title' do
  @title = params[:title]
  @details = []
  list_file = File.new('movies.csv', 'r')
  list_file.each do |movie|
    if movie.split('|')[0] == @title then
      @details = movie.split('|')
  end
end
  erb :movie
end

# This page creates a form to search for a new movie
get '/movie_query' do
  erb :movie_query
end

# Create a new movie by sending a POST request to this URL ##MODIFY COMMENT
post '/movie_query' do
  f = File.new('movies.csv', 'a+')
  @title = params[:title]
  my_movie = Imdb::Search.new(@title).movies.first
  @title = my_movie.title
  @year = my_movie.year
  @director = my_movie.director
  @poster = my_movie.poster
  f.puts("#{@title}|#{@year}|#{@director}|#{@poster}")
  f.close
  redirect to("/movie/#{URI::encode(@title)}")
end


#Ability to access static HTML about page (i like horror movies)