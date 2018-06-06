Rails.application.routes.draw do

	namespace :api do 
		namespace :v1 do
			resources(
				:artists, 
				:only => [:index, :show, :edit], 
				:defaults => { :format => :json } 
			) do 
				resources(
					:albums, 
					:only => [:index, :show, :edit, :new],
					:defaults => { :format => :json }
				) do
					resources(
						:tracks, 
						:only => [:index, :show],
						:defaults => { :format => :json }
					)
				end
			end
		end
	end

	get 'music/index'
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
