class Track < ApplicationRecord
	self.table_name = 'track'
	belongs_to :album, :class_name => 'Album', :foreign_key => 'album_id'
end

