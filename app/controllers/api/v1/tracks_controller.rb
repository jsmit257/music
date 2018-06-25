class Api::V1::TracksController < ApplicationController

	before_action :set_track, only: [:show, :edit, :update, :destroy]

	def index
		@album = Album.find(params[:album_id])  # need artist_id for compatibility with search and API styles
		@tracks = Track
			.joins(:album)
			.where(:album_id => params[:album_id])
		respond_to do |format|
			format.html
			format.json { render :json => track }
		end
	end

	def show
		respond_to do |format| 
			format.html
			#format.mp3
			#format.ogg
		end
	end

	def new
		@track = Track.new
	end

	def edit
	end

	def create
		@track = Track.new(track_params)
		if @track.save
			redirect_to @track, notice: 'Track was successfully created.'
		else
			render :new
		end
	end

	def update
		if @track.update(track_params)
			redirect_to @track, notice: 'Track was successfully updated.' 
		else
			render :edit
		end
	end

	def destroy
		@track.destroy
		redirect_to tracks_url, notice: 'Track was successfully destroyed.'
	end

	private

	def set_track
		@track = Track.eager_load(:album).find(params[:id])
	end

	def track_params
		params.permit(:name, :file, :year, :genre)
	end

	def track
		result = {}
		@tracks.map do |track| 
			result["/artists/#{track.album.artist_id}/albums/#{track.album.id}/tracks/#{track.id}"] = track.as_json
		end
		result
	end

end

