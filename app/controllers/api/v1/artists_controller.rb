class Api::V1::ArtistsController < ApplicationController
	
	before_action :set_artist, only: [:show, :edit, :update, :destroy]

	def index
		@artists = Artist.all
		respond_to do |format|
			format.html
			format.json { render :json => artist }
		end
	end

	def show
		respond_to do |format|
#			format.tar
			format.html
		end
	end

	def new
		@artist = Artist.new
	end

	def edit
	end

	def create
		@artist = Artist.new(artist_params)
		if @artist.save
			redirect_to @artist, notice: 'Artist was successfully created.'
		else
			render :new
		end
	end

	def update
		if @artist.update(artist_params)
			redirect_to @artist, notice: 'Artist was successfully updated.'
		else
			render :edit
		end
	end

	def destroy
		@artist.destroy
		redirect_to artists_url, notice: 'Artist was successfully destroyed.'
	end

	private
	def set_artist
		@artist = Artist.find(params[:id])
	end

	def artist_params
		params.permit(:name)
	end

	def artist 
		result = {}
		@artists.map do |artist| 
			# this is a symptom of search; wanat a uniform object model
			result["/artists/#{artist.id}"] = artist.as_json
		end
		result
	end

end

