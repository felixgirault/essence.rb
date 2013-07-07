#
#	AUTHOR Félix Girault <felix.girault@gmail.com>
#	LICENCE FreeBSD License (http://opensource.org/licenses/BSD-2-Clause)
#

module Essence
module Utility

	#
	#	An utility class to manipulate data sets.
	#

	class Set

		#
		#	Reindexes an array, according to the given correspondances.
		#

		def self.reindex( data, correspondances )

			reindexed = { }

			data.each do | key, value |
				reindexed[ correspondances[ key ] || key ] = value
			end

			reindexed
		end
	end

end # Utilities
end # Essence
