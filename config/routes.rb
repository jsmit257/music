Rails.application.routes.draw do

	namespace :api do 
		namespace :v1 do
			resources :artists, :only => [:index, :show] do 
				resources :albums, :only => [:index, :show] do
					resources :tracks, :only => [:index, :show]
				end
			end
		end
	end

	get 'music/index'
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
