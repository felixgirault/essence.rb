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

		def initialize( providers = { }, options = { })

			@collection = providers.is_a?( ProviderCollection )
				? providers
				: ProviderCollection.new( providers )

			@options = {
				:url_pattern => /(?<!")(?<url>(?:https?:\/\/|www\d{0,3}[.]|[a-z0-9.\-]+[.][a-z]{2,4}\/)(?:[^\s()<>]+|\(([^\s()<>]+|(\([^\s()<>]+\)))*\))+(?:\(([^\s()<>]+|(\([^\s()<>]+\)))*\)|[^\s`!()\[\]{};:\'"\.,<>?«»“”‘’]))/,
				:property_pattern => /%(?<property>[\s\S]+?)%/
			}.merge( options )
		end



		#
		#	Extracts embeddable URLs from either an URL or an HTML source.
		#	If the URL can be parsed directly by one of the registered providers,
		#	it is returned as is. Otherwise, the page is parsed to find such URLs.
		#

		def extract( source )

			@extract ||= { }
			@extract[ local_variables ] ||= (

				if ( url =~ URI::regexp )
					return [ source ] if @collection.has_provider?( source )
					source = HTTP.get( URI( source ))
				end

				urls = self._extract_urls( source )
				embeddable = [ ]

				urls.each do | url |
					embeddable.push( url ) if @collection.has_provider?( url )
				end

				embeddable.uniq
			)
		end



		#
		#	Fetches embed informations from the given URL.
		#	This method now supports an array of options that can be interpreted
		#	at will by the providers.
		#	Thanks to Peter Niederlag (https://github.com/t3dev) for his request
		#	(https://github.com/felixgirault/essence/pull/1).
		#

		def embed( url, options = [ ])

			@embed ||= { }
			@embed[ local_variables ] ||= (

				providers = @collection.providers( url )
				media = nil

				providers.each do | provider |
					if ( media = provider.embed( url, options ))
						break;
					end
				end

				media
			)
		end



		#
		#	Fetches embed informations from the given URLs.
		#

		def embed_all( urls, options = [ ])

			medias = [ ]

			urls.each do | url |
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
		#	Thanks to Stefano Zoffoli (https://github.com/stefanozoffoli) for
		#	his idea (https://github.com/felixgirault/essence/issues/4).
		#

		def replace( text, template = '', options = [ ])

			text.gsub( @options[ :url_pattern ]) do | matches |
				media = self.embed( matches[ :url ], options )
				replacement = ''

				if media.is_a?( Media )
					if template.empty?
						replacement = media.get( 'html' )
					else
						replacement = template.gsub( @options[ :property_pattern ]) do | matches |
							media.get( matches[ :property ])
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

			options = {
				'a' => 'href',
				'embed' => 'src',
				'iframe' => 'src'
			}

			attributes = Registry::get( 'dom' ).extract_attributes( html, options )
			urls = [ ]

			options.each do | tag_name, attribute_name |
				attributes[ tag_name ].each do | _, tag |
					urls.push( tag[ attribute_name ])
				end
			end

			urls
		end
	end

end # Essence
