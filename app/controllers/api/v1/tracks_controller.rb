class Api::V1::TracksController < ApplicationController

	before_action :set_track, only: [:show, :edit, :update, :destroy]

	def index
		@tracks = Track
			.joins(:album)
			.where(:album_id => params[:album_id])
		respond_to do |format|
			format.html
			format.json { render :json => @tracks.to_json }
		end
	end

	def show
		respond_to do |format| 
			format.html
			format.json { render :json => @track.to_json }
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
		respond_to do |format|
			if @track.save
				format.html { redirect_to @track, notice: 'Track was successfully created.' }
			else
				format.html { render :new }
			end
		end
	end

	def update
		respond_to do |format|
			if @track.update(track_params)
				format.html { redirect_to @track, notice: 'Track was successfully updated.' }
			else
				format.html { render :edit }
			end
		end
	end

	def destroy
		@track.destroy
		respond_to do |format|
			format.html { redirect_to tracks_url, notice: 'Track was successfully destroyed.' }
		end
	end

	private

	def set_track
		@track = Track.find(params[:id])
	end

	def track_params
		params.permit(:name, :file, :year, :genre)
	end

end

