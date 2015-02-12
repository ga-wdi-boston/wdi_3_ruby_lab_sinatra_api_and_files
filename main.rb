require 'rubygems'
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'imdb'

get '/' do
    favorite_movies = File.new('movies.csv', 'r')
    @movies = []
    favorite_movies.each do |line|
      @movies << line.split('|')
    end
    favorite_movies.close
    erb :home
end

get '/movies/:title' do
    @title = params[:title]
    favorite_movies = File.new('movies.csv', 'r')
    @movie_information =[]
    favorite_movies.each do |line|
      if line.split('|')[0] == @title
        @movie_information = line.split('|')
      end
    end
    favorite_movies.close
    erb :movie
end

get '/new_movie' do
    erb :input
end

post '/add_new_movie' do
    @title = params[:title]
    new_movie = Imdb::Search.new(@title).movies.first
    @year = new_movie.year
    new_movie =File.new('movies.csv', 'a+')
    new_movie.puts("#{@title}|#{@year}")
    new_movie.close
    redirect to("/")
end


