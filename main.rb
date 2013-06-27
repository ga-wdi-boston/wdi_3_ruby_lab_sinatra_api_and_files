require 'rubygems'
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'imdb'

get '/' do
	@favorites = {}
	f= File.new('movies.csv', 'r')
	f.each do |line|
		@favorites[line.split(',').to_sym] = line.split(',')
	end
	erb :favorites
end

get '/new_favorite/?:new_movie?' do
	if params[:new_movie] then
		f= File.new('movies.csv','r')
		@new_movie = Imbd::Search.new(:new_movie).movies.first
		redirect to('new_favorite/URI::encode(:new_movie)')
	end
	erb :new_favorite
end


get '/movie/:movie_title' do
	f = File.new('movies.csv', 'r')
	f.each do |line|
		if line.split(',')[0] == movie_title
			@movie = line
			erb :movie
		end
	end
end
