class Api::V1::AlbumsController < ApplicationController

	before_action :set_album, only: [:show, :edit, :update, :destroy]

	def index
		puts params
		@albums = Album
			.joins(:artist)
			.where(:artist_id => params[:artist_id]) 
		respond_to do |format|
			format.html
			format.json { render :json => @albums .to_json(:include => :tracks) }
		end
	end

	def show
		respond_to do |format| 
#			format.tar
			format.html
			format.json { render :json => @album.to_json(:include => :tracks) }
		end
	end

	def new
		@album = Album.new
	end

	def edit
	end

	def create
		@album = Album.new(album_params)

		respond_to do |format|
			if @album.save
				format.html { redirect_to @album, notice: 'Album was successfully created.' }
				format.json { render :show, status: :created, location: @album }
			else
				format.html { render :new }
				format.json { render json: @album.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		respond_to do |format|
			if @album.update(album_params)
				format.html { redirect_to @album, notice: 'Album was successfully updated.' }
				format.json { render :show, status: :ok, location: @album }
			else
				format.html { render :edit }
				format.json { render json: @album.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@album.destroy
		respond_to do |format|
			format.html { redirect_to albums_url, notice: 'Album was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_album
		@album = Album.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def album_params
		params.fetch(:album, {})
	end
end
