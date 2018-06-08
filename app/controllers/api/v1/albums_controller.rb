class Api::V1::AlbumsController < ApplicationController

	before_action :set_album, only: [:show, :edit, :update, :destroy]

	def index
		@albums = Album
			.joins(:artist)
			.where(:artist_id => params[:artist_id]) 
		respond_to do |format|
			format.html
			format.json { render :json => @albums.to_json(:include => :tracks) }
		end
	end

	def show
		respond_to do |format| 
#			format.tar { render :text => proc {}, :content_type => :tar }  # major limitation is content-disposition and filename
			format.tar { send_data "", :filename => "", :type => :tar, :disposition => "attachment" }
			format.html
			format.json { render :json => @album.to_json(:include => :tracks) }
		end
	end

	def new
		@album = Album.new
	end

	def edit
	end

	# none of the below can render JSON, so respond_to might be unnecessary
	def create
		@album = Album.new(album_params)
		respond_to do |format|
			if @album.save
				format.html { redirect_to @album, notice: 'Album was successfully created.' }
			else
				format.html { render :new }
			end
		end
	end

	def update
		respond_to do |format|
			if @album.update(album_params)
				format.html { redirect_to @album, notice: 'Album was successfully updated.' }
			else
				format.html { render :edit }
			end
		end
	end

	def destroy
		@album.destroy
		respond_to do |format|
			format.html { redirect_to albums_url, notice: 'Album was successfully destroyed.' }
		end
	end

	private
	def set_album
		@album = Album.find(params[:id])
	end

	def album_params
		params.fetch(:album, {})
	end
end
