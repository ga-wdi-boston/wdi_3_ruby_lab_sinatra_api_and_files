require 'rubygems'
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'imdb'

get '/' do

@movie_title = params[:movie_title]
if @movie_title
    redirect to "/movies/#{@movie_title}"
  else
    "What was that? Try another movie"
  end
  erb :search
end

get '/movies/:movie_title' do
  @movie_title = params[:movie_title]
  @movie = Imdb::Search.new(@movie_title)

  erb :movie

end

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