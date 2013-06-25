#
module Essence



# The Essence class.
class Essence

	#
	def initialize( providers = [ ])

		@collection = ProviderCollection.new( providers )
	end



	#
	def embed( url, options = [ ])

		providers = @collection.providers( url )
		media = nil

		providers.each do |provider|
			begin
				media = provider.embed( url, options )
			rescue Exception

			end

			break if media !== nil
		end

		media
	end



	#
	def embed_all( urls, options = [ ])

		medias = [ ]

		urls.each do |url|
			medias[ url ] = self.embed( url, options )
		end

		medias
	end



	#
	def replace( text, template = '', options = [ ])

		link_pattern = /(\s)(([\w-]+:\/\/?|www[.])[^\s()<>]+(?:\([\w\d]+\)|([^[:punct:]\s]|\/)))/;
		symbol_pattern = /%([\s\S]+?)%/;

		text.gsub( link_pattern ) do |link|
			media = self.embed( link, options )
			replacement = ''

			if ( media !== nil )
				if ( template.empty? )
					replacement = media.get( 'html' )
				else
					replacement = template.gsub( symbol_pattern ) do |symbol|
						media.get( symbol )
					def
				end
			end

			replacement
		end
	end
end

end # module
