class SearchController < ApplicationController

	before_action :set_search, only: [:index]

	def index
		render :json => send(@scope, {})
	end

	def artists result

		Artist
		.where('name like ?', "%#{@what}%")
		.each do |artist| 
			result["/api/v1/artists/#{artist.id}"] = artist.as_json.merge({ :search_found => true })
		end

		return result

	end

	def albums result

		Album
		.eager_load(:artist)
		.joins(:artist => :albums)
		.where('albums_artist.name like ?', "%#{@what}%")
		.each do |album| 
			artist_key = "/api/v1/artists/#{album.artist.id}"
			artist = (result[artist_key] or result[artist_key] = album.artist.as_json)
			artist[:search_parent_found] = true
			albums = (artist[:children] or artist[:children] = {})
			album_key = "#{artist_key}/albums/#{album.id}"
			(albums[album_key] or albums[album_key] = album.as_json)[:search_found] = true if !(/#{@what}/i =~ album.name).nil?
		end

		return result

	end

	def tracks result

		Track
		.eager_load(:album => :artist)
		.joins(:album => { :artist => { :albums => :tracks } })
		.where('tracks_album.name like ?', "%#{@what}%")
		.each do |track|
			search_found = !(/#{@what}/i =~ track.name).nil?
			artist_key = "/api/v1/artists/#{track.album.artist.id}"  # version should be dynamic
			artist = (result[artist_key] or result[artist_key] = track.album.artist.as_json)
			artist[:search_parent_found] = true
			albums = (artist[:children] or artist[:children] = {})
			album_key = "#{artist_key}/albums/#{track.album.id}"
			album = (albums[album_key] or albums[album_key] = track.album.as_json)
			album[:search_parent_found] = true if search_found
			tracks = (album[:children] or album[:children] = {})
			track_key = "#{album_key}/tracks/#{track.id}"
			tracks[track_key] = track.as_json
			tracks[track_key][:search_found] = true if search_found 
		end

		return result

	end

	def all result
		tracks(albums(artists(result)))
	end

	private

	def set_search 
		@scope = params[:scope]
		raise "unsupported search scope #{@scope}" if not self.respond_to? @scope
		@what = params[:what]
		raise "query string is two short, need at least 3 chars to search" if not @what.length > 2

	end

end

