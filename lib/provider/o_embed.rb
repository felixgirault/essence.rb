#
#	AUTHOR Félix Girault <felix.girault@gmail.com>
#	LICENCE FreeBSD License (http://opensource.org/licenses/BSD-2-Clause)
#

require 'json'
require 'xmlsimple'

module Essence
module Providers

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

		def _prepare( url )

			url = super

			if !self._strip!( url, '?' )
				self._strip!( url, '#' )
			end

			url
		end



		#
		#	Strips the end of a string after a delimiter.
		#

		def _strip!( url, delimiter )

			index = url.rindex( delimiter )
			found = !index.is_nil?

			if found
				url = url[ 0..index ]
			end

			found
		end



		#
		#
		#

		def _embed( url, options )

			self._embed_endpoint(
				@options[ :endpoint ] % url,
				@options[ :format ],
				options
			)
		end



		#
		#
		#

		def _embed_endpoint( endpoint, format, options )

			response = HTTP.get( URI(
				self._completeEndpoint( endpoint, options )
			))

			data = case format
				when JSON
					then JSON.parse( response )

				when XML
					then XmlSimple.xml_in( response )

				else
					raise Error.new( 'Unsupported format.' )
			end

			return Media.new( data )
		end



		#
		#
		#

		def _complete_endpoint( endpoint, options )

			if !options.empty?
				params = { } # intersection

				if !params.empty?
					endpoint << endpoint.index( '?' ).is_nil? ? '?' : '&'
					endpoint << params.to_s
				end
			}

			return endpoint
		end
	end

end # Provider
end # Essence
