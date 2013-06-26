#
#	AUTHOR Félix Girault <felix.girault@gmail.com>
#	LICENCE FreeBSD License (http://opensource.org/licenses/BSD-2-Clause)
#

module Essence
	module Provider

		#
		#
		#

		class OpenGraph

			#
			#
			#

			def initialize( options = [ ])
				@options = @defaults.merge( options )
			end
		end

	end # Provider
end # Essence
