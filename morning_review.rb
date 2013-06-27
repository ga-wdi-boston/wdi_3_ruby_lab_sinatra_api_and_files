




get '/' do

end

  # by analogy
  # '/l/addition/2'
  # get '/:first/:operation/:second'
  # param[:first].to_f


post '/newmovie/:title' do
  # the user has posted data from the form,
  # imdb api to go search for the title
  # @ titile is a string
  @title = params[:titile]

  # A movie with the title "@title"
  @movie = Imdb::Search.new("Batman").movies.first
  # Don't forget that you can debut this way
  # puts "Movie details:"
    puts @movie

  end

title = @movie.title
year = @movie.year

output_file = File.new('movies.csv', 'a+')
output_file.puts("#{@title}, #{@year}")
output_file.close

rediret to '/'