#
#	AUTHOR Félix Girault <felix.girault@gmail.com>
#	LICENCE FreeBSD License (http://opensource.org/licenses/BSD-2-Clause)
#

module Essence

	#
	#
	#

	class Media

		attr_reader :properties



		#
		#
		#

		def initialize( properties = { })

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
				'author_name' => '',

				# OEmbed author_url
				'author_url' => '',

				# OEmbed provider_name
				# OG site_name
				'provider_name' => '',

				# OEmbed provider_url
				'provider_url' => '',

				# OEmbed cache_age
				'cache_age' => '',

				# OEmbed thumbnail_url
				# OG image
				# OG image:url
				'thumbnail_url' => '',

				# OEmbed thumbnail_width
				'thumbnail_width' => '',

				# OEmbed thumbnail_height
				'thumbnail_height' => '',

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
