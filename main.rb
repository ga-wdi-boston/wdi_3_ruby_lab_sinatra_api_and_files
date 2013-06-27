require 'rubygems'
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'imdb'




    get '/movies' do

      movies_file = File.open("/movies.csv", "+a")
        movie = []
        movie << ["row", "of", "CSV", "data"]
        movie << ["another", "row"]
      end




    # get '/movies/:name' do

    #    @name = params[:name]

     #  my_movie = Imdb::Search.new(:name).movies.first

     #  film = []

     #  film << my_movie.title
     #  film << my_movie.poster
     #  film << my_movie.year
     #  csv  << film


get '/new_movie' do


 erb :new_movie
end

post '/movie' do



 erb :movie
end




def movie_getter()
my_movie = Imdb::Search.new(name).movies.first
puts my_movie.title
puts my_movie.poster
puts my_movie.year
end
