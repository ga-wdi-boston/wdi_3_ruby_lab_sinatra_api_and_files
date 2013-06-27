require 'rubygems'

# More documentation about this gem at https://github.com/ariejan/imdb
require 'imdb'

# Use the first search result. Here I'm searching for the "Jobs" movie.
my_movie = Imdb::Search.new("Jobs").movies.first
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

#[:id, :id=, :url, :url=, :title, :title=, :also_known_as, :also_known_as=, :cast_members, :cast_member_ids, :cast_characters, :cast_members_characters,
# :director, :trailer_url, :genres, :languages, :countries, :length, :company, :plot, :plot_synopsis, :plot_summary, :poster, :rating, :votes, :tagline,
# :mpaa_rating, :year, :release_date
