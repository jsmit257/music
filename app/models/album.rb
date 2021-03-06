class Album < ApplicationRecord
	self.table_name = 'album'
	has_many :tracks, :class_name => 'Track', :foreign_key => 'album_id'
	belongs_to :artist, :class_name => 'Artist', :foreign_key => 'artist_id'
end
