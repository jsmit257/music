class Artist < ApplicationRecord
	self.table_name = 'artist'
	has_many :albums, :class_name => 'Album', :foreign_key => 'artist_id'
end
