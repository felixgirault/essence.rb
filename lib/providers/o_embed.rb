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
				:endpoint => '',
				:format => JSON
			}.merge( options ))
		end

	protected

		#
		#
		#

		def _prepare( url ) {

			url = super

			if ( !self._strip( url, '?' ))
				self._strip( url, '#' )
			end

			url
		end



		#
		#
		#

		def _strip( url, delimiter ) {

			index = url.index( delimiter )
			found = ( index !== nil )

			if ( found )
				url = url[ 0..index ]
			end

			found
		end
	end

end # Provider
end # Essence
