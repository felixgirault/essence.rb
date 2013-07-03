#
#	AUTHOR Félix Girault <felix.girault@gmail.com>
#	LICENCE FreeBSD License (http://opensource.org/licenses/BSD-2-Clause)
#

module Essence

	#
	#
	#

	class Media

		#
		#
		#

		def initialize( properties = [ ])

			@properties = {
				# OEmbed type
				# OG type
				'type' => '',

				# OEmbed version
				'version' => '',

				# OEmbed title
				# OG title
				'title' => '',

				# Sometimes provided in OEmbed (i.e. Vimeo)
				# OG description
				'description' => '',

				# OEmbed author_name
				'authorName' => '',

				# OEmbed author_url
				'authorUrl' => '',

				# OEmbed provider_name
				# OG site_name
				'providerName' => '',

				# OEmbed provider_url
				'providerUrl' => '',

				# OEmbed cache_age
				'cacheAge' => '',

				# OEmbed thumbnail_url
				# OG image
				# OG image:url
				'thumbnailUrl' => '',

				# OEmbed thumbnail_width
				'thumbnailWidth' => '',

				# OEmbed thumbnail_height
				'thumbnailHeight' => '',

				# OEmbed html
				'html' => '',

				# OEmbed width
				# OG image:width
				# OG video:width
				'width' => '',

				# OEmbed height
				# OG image:height
				# OG video:height
				'height' => '',

				# OEmbed url
				# OG url
				'url' => ''

			}.merge( properties )
		end



		#
		#
		#

		def has?( property )

			@properties.has_key?( property )
		end



		#
		#
		#

		def get( property, default = '' )

			@properties.fetch( property, default )
		end



		#
		#
		#

		def set( property, value )

			@properties[ property ] = value
		end
	end

end # Essence
