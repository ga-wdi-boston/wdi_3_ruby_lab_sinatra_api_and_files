require 'rubygems'

# More documentation about this gem at https://github.com/ariejan/imdb
require 'imdb'
require 'pry'

# Use the first search result. Here I'm searching for the "Jobs" movie.
my_movie = gets.chomp
movie = Imdb::Search.new(my_movie).movies.first
# binding.pry
puts my_movie.title
puts my_movie.poster
puts my_movie.year


#### Methods on an individual movie
#company
#genres (multiple)
#length
#director
#mpaa_rating
#plot_synopsis
#tagline
#year
#poster
#release_date