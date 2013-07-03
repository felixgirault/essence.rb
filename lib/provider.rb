#
#	AUTHOR Félix Girault <felix.girault@gmail.com>
#	LICENCE FreeBSD License (http://opensource.org/licenses/BSD-2-Clause)
#

module Essence

	#
	#
	#

	class Provider

		#
		#
		#

		def initialize( options = { })

			@options = options
		end



		#
		#
		#

		def embed( url, options = { }) {

			url = self._prepare( url )
			media = self._embed( url, options )

			if ( media && !media.get( 'url' )) {
				media->set( 'url', url )
			}

			media
		end

	protected

		#
		#
		#

		def _prepare( url ) {

			url.strip( )
		end



		#
		#
		#

		def embed( url, options )

			raise NotImplementedError.new
		end
	end

end # Essence
