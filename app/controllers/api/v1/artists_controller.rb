class Api::V1::ArtistsController < ApplicationController
	
	before_action :set_artist, only: [:show, :edit, :update, :destroy]

	def index
		@artists = Artist.all
		respond_to do |format|
			format.html
			format.json { render :json => @artists }
		end
	end

	def show
		respond_to do |format|
#			format.tar
			format.html
			format.json { render :json => @artist.to_json(:include => :albums) }
		end
	end

	def new
		@artist = Artist.new
	end

	def edit
	end

	def create
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

	def update
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

	def destroy
		@artist.destroy
		respond_to do |format|
			format.html { redirect_to artists_url, notice: 'Artist was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private
	def set_artist
		@artist = Artist.find(params[:id])
	end

	def artist_params
		params.fetch(:artist, {})
	end
end
