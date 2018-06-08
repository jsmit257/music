Rails.application.routes.draw do

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

	scope :module => 'api/v1', :only => [:index, :show, :new, :edit, :update, :destroy], :constraints => { :format => :html } do 
		resources :artists
		resources :albums
		resources :tracks
	end

	get 'music/index'

end
