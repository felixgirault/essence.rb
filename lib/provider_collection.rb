#
#	AUTHOR Félix Girault <felix.girault@gmail.com>
#	LICENCE FreeBSD License (http://opensource.org/licenses/BSD-2-Clause)
#

module Essence

	#
	#
	#

	class ProviderCollection

		#
		#
		#

		def initialize( providers = { })

			@providers = {

			}.merge( providers )
		end



		#
		#
		#

		def has_provider?( url )

		end
	end

end # Essence
