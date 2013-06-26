require 'rubygems'
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'imdb'

get '/' do
	erb :favorites
end

get '/new_favorite/?:new_movie?' do
	if params[:new_movie]
		@new_movie = params[:new_movie]
	else
		@new_movie = " "
	end
	erb :new_favorite
end
