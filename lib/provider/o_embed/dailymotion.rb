#
#	AUTHOR Félix Girault <felix.girault@gmail.com>
#	LICENCE FreeBSD License (http://opensource.org/licenses/BSD-2-Clause)
#

module Essence
module Provider
module OEmbed

	#
	#	Dailymotion provider (http://www.dailymotion.com).
	#

	class Dailymotion < Oembed

		#
		#
		#

		def _embed( url, options )

			media = super

			if media.has?( 'thumbnail_url' )
				media.set(
					'thumbnail_url',
					media.get( 'thumbnail_url' ).sub(
						'jpeg_preview_large',
						'jpeg_preview_source'
					)
				)
			end

			media
		end
	end

end # OEmbed
end # Provider
end # Essence
