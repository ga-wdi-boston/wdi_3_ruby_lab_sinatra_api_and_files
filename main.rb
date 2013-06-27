require 'rubygems'
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'imdb'

helpers do
	# as great as "Jobs (2013) looks, I only want one copy"
	def movie_exists?(title)
		f = File.new('movies.csv', 'r')
		f.each do |line|
			return true if line.split('|')[0] == title
		end
		false
	end
end


get '/about' do
	@favorites = {}
	f= File.new('movies.csv', 'r')
	f.each do |line|
		@favorites[line.split('|').to_sym] = line.split(',')
	end
	erb :favorites
end

get '/new_favorite/?:new_movie?' do
	if params[:new_movie] then
		f = File.new('movies.csv', 'a+')
		@new_movie = Imdb::Search.new(params[:new_movie]).movies.first
		@title = @new_movie.title
		@year = @new_movie.year
		@director = @new_movie.director
		@poster = @new_movie.poster
		@rating = @new_movie.rating
		f.puts "#{@title}| #{@year}| #{@director}| #{@poster}|#{@rating}\n" unless movie_exists?(@title)
		f.close
		redirect to("/movie/#{URI::encode(@title)}")
	else
		erb :new_favorite
	end
end


get '/movie/:movie_title' do
	f = File.new('movies.csv', 'r')
	f.each do |line|
		if line.split('|')[0] == "#{URI::decode(params[:movie_title])}"
			@movie = line
			erb :movie
		end
	end
end
