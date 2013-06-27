require 'rubygems'
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'imdb'


get '/favorite_movies' do
  movie_file = File.new("movies.csv", "r")
  @movies = {}
  movie_file.each do |movie_line|
    split_line=movie_line.split(",")
    title = split_line[0]
    @movies[title] = split_line
  end
    erb :movies
end



get '/add_movie' do
@movie = params[:movie]
my_movie = Imdb::Search.new(@movie).movies.first
@title = my_movie.title
@plot_summary = my_movie.company
@length = my_movie.length
@director = my_movie.director.first

output_file = File.new('movies.csv', 'a+')
output_file.puts("#{@title},#{@company},#{@length},#{@director}")
output_file.close

redirect to "/favorite_movies/#{@movie}"
end



get '/favorite_movies/:movie' do
  @movie = params[:movie]
  movie_file = File.new("movies.csv", "r")
  @movies = {}
  movie_file.each do |movie_line|
    split_line=movie_line.split(",")
    title = split_line[0]
    @movies[title] = split_line
  end
    erb :movie

end



#    get '/form' do
#   @movie = params[:movie]
#      if @movie
#     redirect to("/#{@movie}")
#   else
#     puts "Enter a valid username"
#   end
#   erb :form
# end




# get '/:movie' do
#   @movie = params[:movie]
#   my_movie = Imdb::Search.new("#{@movie}").movies.first
#   #@movie_list = my_movie.title

#   erb :movies
# end

# title = @movie.title
# plot_summary = @movie.plot_summary

# output_file = File.new('movies.csv', 'a+')

# output_file.puts("#{title}| #{plot_summary}")
# output_file.close

# redirect to '/'
