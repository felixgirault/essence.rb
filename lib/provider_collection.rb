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

		def initialize( providers = [ ])

			@providers = [ ]

			self.load( providers )
		end



		#
		#
		#

		def load( providers = [ ])

			Dir[ ].each do |file|
				require File.basename( file )
			end
		end



		#
		#
		#

		def has_provider?( url )

			@providers.find do |provider|
				provider.can_embed?( url )
			end
		end
	end

end # Essence
