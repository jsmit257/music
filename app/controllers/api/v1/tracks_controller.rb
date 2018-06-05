class Api::V1::TracksController < ApplicationController
	before_action :set_track, only: [:show]

	# GET /tracks
	# GET /tracks.json
	def index
		respond_to do |format|
			format.json do 
				render :json => Track
					.joins(:album)
					.where(:album_id => params[:album_id])
					.to_json
			end
		end
	end

	# GET /tracks/1
	# GET /tracks/1.json
	def show
		respond_to do |format| 
			format.json { render :json => @track.to_json }
		end
	end

	# GET /tracks/new
	def new
		raise 'operation not supported'
		@track = Track.new
	end

	# GET /tracks/1/edit
	def edit
		raise 'operation not supported'
	end

	# POST /tracks
	# POST /tracks.json
	def create
		raise 'operation not supported'
		@track = Track.new(track_params)

		respond_to do |format|
			if @track.save
				format.html { redirect_to @track, notice: 'Track was successfully created.' }
				format.json { render :show, status: :created, location: @track }
			else
				format.html { render :new }
				format.json { render json: @track.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /tracks/1
	# PATCH/PUT /tracks/1.json
	def update
		raise 'operation not supported'
		respond_to do |format|
			if @track.update(track_params)
				format.html { redirect_to @track, notice: 'Track was successfully updated.' }
				format.json { render :show, status: :ok, location: @track }
			else
				format.html { render :edit }
				format.json { render json: @track.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /tracks/1
	# DELETE /tracks/1.json
	def destroy
		raise 'operation not supported'
		@track.destroy
		respond_to do |format|
			format.html { redirect_to tracks_url, notice: 'Track was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_track
		@track = Track.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def track_params
		params.fetch(:track, {})
	end
end
