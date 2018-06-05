class Api::V1::ArtistsController < ApplicationController
	before_action :set_artist, only: [:show]

	# GET /artists
	# GET /artists.json
	def index
		respond_to do |format|
			format.json { render :json => Artist.all }
		end
	end

	# GET /artists/1
	# GET /artists/1.json
	def show
		respond_to do |format|
#			format.tar
			# we don't save anything about artists except their albums, and we already have an 
			# /artists/:artist_id/albums => albums#index; we left this here for the hell of it
			# but it's really the tar format that we care about
			format.json { render :json => @artist.to_json(:include => :albums) }
		end
	end

	# GET /artists/new
	def new
		raise 'operation not supported'
	end

	# GET /artists/1/edit
	def edit
		raise 'operation not supported'
	end

	# POST /artists
	# POST /artists.json
	def create
		raise 'operation not supported'
		@artist = Artist.new(artist_params)

		respond_to do |format|
			if @artist.save
				format.html { redirect_to @artist, notice: 'Artist was successfully created.' }
				format.json { render :show, status: :created, location: @artist }
			else
				format.html { render :new }
				format.json { render json: @artist.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /artists/1
	# PATCH/PUT /artists/1.json
	def update
		raise 'operation not supported'
		respond_to do |format|
			if @artist.update(artist_params)
				format.html { redirect_to @artist, notice: 'Artist was successfully updated.' }
				format.json { render :show, status: :ok, location: @artist }
			else
				format.html { render :edit }
				format.json { render json: @artist.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /artists/1
	# DELETE /artists/1.json
	def destroy
		raise 'operation not supported'
		@artist.destroy
		respond_to do |format|
			format.html { redirect_to artists_url, notice: 'Artist was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_artist
		@artist = Artist.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def artist_params
		params.fetch(:artist, {})
	end
end