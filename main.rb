require 'rubygems'
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'imdb'

get '/' do
  @movies = []
  movies = File.new('movies.csv', 'r')
  movies.each do |title|
    @movies << title.split(',')
  end
    erb :movies
end


# if @movie_title
#     redirect to "/movies/#{@movie_title}"
#   else
#     "What was that? Try another movie"
# end




get '/movies/:movie_title' do
  @movie_title = params[:movie_title]
  @single_movie = []
  movies_file = File.new('movies.csv', 'r')
  movies_file.each do |movie_title|
    movie_title.split

  if movie_title.split(',')[0] == @movie_title
      then @single_movie = movie_title.split(',')
    end
  end
  erb :movie
end

get '/new_movie' do
  erb :new_movie
end

post '/new_movie' do
  @movie_title = params[:movie_title]
  @movie = Imdb::Search.new(@movie_title).movies.first
  movies = File.open('movies.csv', 'a+') do |movie_title|
   movie_title.puts("#{@movie.title},#{@movie.year},#{@movie.director[0]},#{@movie.poster}")
  end
end



# ----------------------------------------
# These are from examples, for reference.

# post '/new_movie/:movie_title' do
#   @title = params[:movie_title]
#   @movie =
#   puts "Movie Details"
#   return @movies.inspect

#   erb :search
# end

# title = @movie.title
# plot_summary = @movie.plot_summary

# output_file = File.new('movies.csv', 'a+')
# output_file.puts(#{"title"}, #{plot_summary})
# output_file.close
