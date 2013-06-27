require 'imdb'

# movie_info = [title, year, length, director]

def get_movie(movie)
  @movies = []
  movie = Imdb::Search.new("#{movie}").movies.first.title
  @movies << movie
  puts @movies
end

get_movie("Jobs")


 <a href "<%= @movie_list %>"><%= @movie_list %></a>


 <ul>
<% @movies.each do |title, movie_data| %>
  <li>
<a href="/movie/<%= title %>">
    <%= "#{title}" %>
  </a>
  <%= " Year: #{movie_data[1]}" %> </li>
<% end %>
</ul>