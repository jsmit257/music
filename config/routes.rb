Rails.application.routes.draw do

	# api routes look like api/v1/artists[:artist_id[/albums[:album_id[/tracks[:track_id]]]]]; 
	# compare this with the flat routes below
	namespace(
		:api, 
		:only => [:index, :show], 
		:defaults => { :format => :json }, 
		:constraints => { 
			:format => [ :json, :tar, :mp3, :ogg ] 
		} 
	) do 
		namespace :v1 do
			resources :artists do 
				resources :albums do
					resources :tracks
				end
			end
		end
	end

	# these routes are flat, e.g.: /artists[:artist_id], /albums?artist_id=nnn; most importantly,
	# these routes support full CRUD, while the APIs are read-only
	scope(
		:module => 'api/v1', 
		:only => [:index, :show, :new, :edit, :update, :destroy], 
		:constraints => { 
			:format => :html 
		} 
	) do 
		resources :artists
		resources :albums
		resources :tracks
	end

	get 'music', :to => 'music#index'
	get 'search',
		:to => 'search#index',
		:only => [:index],
		:defaults => { :format => :json},
		:constraints => { :format => :json }

end

