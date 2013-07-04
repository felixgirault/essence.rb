#
#	AUTHOR Félix Girault <felix.girault@gmail.com>
#	LICENCE FreeBSD License (http://opensource.org/licenses/BSD-2-Clause)
#

module Essence
module Provider

	#
	#
	#

	class OEmbed < Provider

		JSON = 'json'
		XML = 'xml'



		#
		#
		#

		def initialize( options = { })

			super({
				# OEmbed endpoint
				:endpoint => '',

				# Expected response format
				:format => JSON

			}.merge( options ))
		end

	protected

		#
		#	Strips arguments and anchors from the given URL.
		#

		def _prepare( url ) {

			url = super

			if ( !self._strip( url, '?' ))
				self._strip( url, '#' )
			end

			url
		end



		#
		#	Strips the end of a string after a delimiter.
		#

		def _strip( url, delimiter ) {

			index = url.index( delimiter )
			found = ( index !== nil )

			if ( found )
				url = url[ 0..index ]
			end

			found
		end



		#
		#
		#

		def _embed( url, options ) {

			self._embed_endpoint(
				@options[ :endpoint ] % url,
				@options[ :format ],
				options
			)
		end



		#
		#
		#

		def _embed_endpoint( )

			response = HTTP.get( URI(
				self._completeEndpoint( endpoint, options )
			))

			data = case format
				when JSON then self._parse_json( response )
				when XML then self._parse_xml( response )

				else raise Error.new( 'Unsupported format.' )
			end

			return Media.new(
				Set::reindex( data, {
					'author_name' => 'authorName',
					'author_url' => 'authorUrl',
					'provider_name' => 'providerName',
					'provider_url' => 'providerUrl',
					'cache_age' => 'cacheAge',
					'thumbnail_url' => 'thumbnailUrl',
					'thumbnail_width' => 'thumbnailWidth',
					'thumbnail_height' => 'thumbnailHeight',
				})
			)
		end



		#
		#
		#

		def _complete_endpoint( endpoint, options )

			endpoint
		end
	end

end # Provider
end # Essence
