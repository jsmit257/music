class SearchController < ApplicationController

	before_action :set_search, only: [:index]

	def index
		render :json => send(@scope).to_json
	end

	def byArtist
		result = []
		Artist
			.where("name like '%#{@what}%'")
			.each do |artist| 
				result.push "/artists/#{artist.id}"
			end
		return result
	end

	def byAlbum
		result = []
		Album
			.where("album.name like '%#{@what}%'")
			.each do |album| 
				result.push "/artists/#{album.artist_id}/albums/#{album.id}"
			end
		return result
	end

	def byTrack
		result = []
		Track
			.eager_load(:album)
			.joins(:album)
			.where("track.name like '%#{@what}%'")
			.each do |track| 
				result.push "/artists/#{track.album.artist_id}/albums/#{track.album.id}/tracks/#{track.id}"
			end
		return result
	end

	def all
		byArtist.concat(byAlbum).concat(byTrack)
	end

	private

	def set_search 
		@scope = params[:scope]
		raise "unsupported search scope #{@scope}" if not self.respond_to? @scope
		@what = params[:what]
		raise "query string is two short, need at least 3 chars to search" if not @what.length > 2

	end

end

