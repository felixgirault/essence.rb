#
#	AUTHOR Félix Girault <felix.girault@gmail.com>
#	LICENCE FreeBSD License (http://opensource.org/licenses/BSD-2-Clause)
#

require 'test/unit'
require_relative '../../lib/utilities/set'

module Essence

	#
	#
	#

	class SetTest < Test::Unit::TestCase

		#
		#
		#

		def test_reindex

			data = Essence::Utilities::Set::reindex(
				{ 'one' => 'value' },
				{ 'one' => 'two' }
			)

			assert_equal(
				{ 'two' => 'value' },
				data
			)
		end
	end

end # Essence
