#
#	AUTHOR Félix Girault <felix.girault@gmail.com>
#	LICENCE FreeBSD License (http://opensource.org/licenses/BSD-2-Clause)
#

require 'test/unit'
require_relative '../../lib/utility/set'

module Essence
module Utility

	#
	#
	#

	class SetTest < Test::Unit::TestCase

		#
		#
		#

		def test_reindex

			data = Essence::Utility::Set::reindex(
				{ 'one' => 'value' },
				{ 'one' => 'two' }
			)

			assert_equal(
				{ 'two' => 'value' },
				data
			)
		end
	end

end # Utility
end # Essence
