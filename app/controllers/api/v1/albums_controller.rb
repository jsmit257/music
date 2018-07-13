class Api::V1::AlbumsController < ApplicationController

	before_action :set_album, only: [:show, :edit, :update, :destroy]

	def index
		@albums = Album
			.joins(:artist)
			.where(:artist_id => params[:artist_id]) 
		respond_to do |format|
			format.html
			format.json { render :json => album }
		end
	end

	def show
		respond_to do |format| 
#			format.tar { render :text => proc {}, :content_type => :tar }  # major limitation is content-disposition and filename
			format.tar { send_data "", :filename => "", :type => :tar, :disposition => "attachment" }
			format.html
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
		if @album.save
			redirect_to @album, notice: 'Album was successfully created.'
		else
			render :new
		end
	end

	def update
		if @album.update(album_params)
			redirect_to @album, notice: 'Album was successfully updated.'
		else
			render :edit
		end
	end

	def destroy
		@album.destroy
		redirect_to albums_url, notice: 'Album was successfully destroyed.'
	end

	private
	def set_album
		@album = Album.find(params[:id])
	end

	def album_params
		params.permit(:name)
	end

	def album
		result = {}
		@albums.map do |album| 
			result["/artists/#{album.artist.id}/albums/#{album.id}"] = album.as_json
		end
		result
	end

end

