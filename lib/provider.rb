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

		def initialize( options = [ ])

			@options = @defaults.merge( options )
		end



		#
		#
		#

		def can_embed?( url )

			true
		end
	end

end # Essence
