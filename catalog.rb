#!/usr/bin/ruby 

class EndOfAlbum < Exception; end

File.open('mpd.txt', 'r:iso-8859-1') do |file|

	@artist
	@album

	begin
		loop do 
			file.readline.chomp.gsub /^directory: (.+)$/ do
				# seems like a bit of an abuse of gsub
				@artist = Artist.create(:name => $1)
				nil while not file.readline.match /^begin:/ 
			end
			loop do 
				break if (line = file.readline).match /^end:/
				line.chomp.gsub /^directory: (.+)$/ do
					@album = @artist.albums.create(:name => $1)
					nil while not file.readline.match /^begin:/
				end
				@filename = @name = @date = @ordinal = @genre = nil
				begin
					loop do
						until (line = file.readline.chomp).match /^song_end$/
							raise EndOfAlbum if line.match /^end:/
							line.gsub(/^(^[^:]+): (.+)$/) do 
								case $1
								when 'song_begin' then @filename = $2
								when 'Title' then @name = $2
								when 'Date' then @date = $2
								when 'Track' then @ordinal = $2
								when 'Genre' then @genre = $2
								end
							end
						end
						p "got a line: ", line
						@album.tracks.create(:file => @filename, :name => @name)
					end
				rescue EndOfAlbum => e
					p "reached the end of album"
				end
			end
		end
	rescue Exception => e
		p "an error occured", e
	end
end


