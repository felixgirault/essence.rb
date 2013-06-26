#
#	AUTHOR Félix Girault <felix.girault@gmail.com>
#	LICENCE FreeBSD License (http://opensource.org/licenses/BSD-2-Clause)
#

require 'uri'

module Essence

	#
	#	Gathers embed informations from URLs.
	#

	class Essence

		#
		#	A collection of providers to query.
		#

		def initialize( providers = [ ])
			@collection = ProviderCollection.new( providers )
		end



		#
		#	Extracts embeddable URLs from either an URL or an HTML source.
		#	If the URL can be parsed directly by one of the registered providers,
		#	it is returned as is. Otherwise, the page is parsed to find such URLs.
		#

		def extract( source )
			if ( url =~ URI::regexp )
				return [ source ] if @collection.has_provider?( source )
				source = HTTP.get( URI( source ))
			end

			urls = self._extract_urls( source );
			embeddable = [ ];

			urls.each do |url|
				if ( @collection.has_provider?( url ))
					embeddable.push( url ) unless embeddable.include?( url );
				end
			end

			embeddable;
		end



		#
		#	Fetches embed informations from the given URL.
		#	This method now supports an array of options that can be interpreted
		#	at will by the providers.
		#	Thanks to Peter Niederlag (https://github.com/t3dev) for his request
		#	(https://github.com/felixgirault/essence/pull/1).
		#

		def embed( url, options = [ ])
			providers = @collection.providers( url )
			media = nil

			providers.each do |provider|
				begin
					media = provider.embed( url, options )
				rescue Exception

				end

				break if media.is_a?( Media )
			end

			media
		end



		#
		#	Fetches embed informations from the given URLs.
		#

		def embed_all( urls, options = [ ])
			medias = [ ]

			urls.each do |url|
				medias[ url ] = self.embed( url, options )
			end

			medias
		end



		#
		#	Replaces URLs in the given text by media informations if they point
		#	on an embeddable resource.
		#	The template parameter controls how informations will replace the
		#	URL. Any property of a media object can be used. For example, to
		#	replace a URL with the title and HTML code of a resource, one could
		#	use this template:
		#	<div>
		#		<span>%title%</span>
		#		<div>%html%</div>
		#	</div>
		#	By default, links will be replaced by the html property of Media.
		#	Thanks to Stefano Zoffoli (https://github.com/stefanozoffoli) for his
		#	idea (https://github.com/felixgirault/essence/issues/4).
		#

		def replace( text, template = '', options = [ ])
			link_pattern = /(\s)(([\w-]+:\/\/?|www[.])[^\s()<>]+(?:\([\w\d]+\)|([^[:punct:]\s]|\/)))/
			symbol_pattern = /%([\s\S]+?)%/

			text.gsub( link_pattern ) do |link|
				media = self.embed( link, options )
				replacement = ''

				if ( media.is_a?( Media ))
					if ( template.empty? )
						replacement = media.get( 'html' )
					else
						replacement = template.gsub( symbol_pattern ) do |symbol|
							media.get( symbol )
						end
					end
				end

				replacement
			end
		end



		protected



		#
		#	Extracts URLs from an HTML source.
		#

		def _extract_urls( html )
			urls = [ ];
			attributes = Registry.get( 'dom' ).extract_attributes(
				html,
				{
					'a' => 'href',
					'embed' => 'src',
					'iframe' => 'src'
				}
			);

			attributes['a'].each do |a|
				urls.push( a['href'])
			end

			attributes['embed'].each do |embed|
				urls.push( embed['src'])
			end

			attributes['iframe'].each do |iframe|
				urls.push( iframe['src'])
			end

			urls
		end
	end

end # Essence
