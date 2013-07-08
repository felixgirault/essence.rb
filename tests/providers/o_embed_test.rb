#
#	AUTHOR Félix Girault <felix.girault@gmail.com>
#	LICENCE FreeBSD License (http://opensource.org/licenses/BSD-2-Clause)
#

require 'test/unit'
require_relative '../../lib/provider/o_embed'

module Essence
module Providers

	#
	#
	#

	class OEmbedTest < Test::Unit::TestCase

		#
		#
		#

		def setup

			@o_embed = OEmbed.new
		end



		#
		#
		#

		def test_prepare

			media = Essence::Providers::OEmbed::embed( 'valid#anchor' )
			assert_equal( 'valid', media.url )

			media = Essence::Providers::OEmbed::embed( 'valid?argument=value' )
			assert_equal( 'valid', media.url )

			media = Essence::Providers::OEmbed::embed( 'valid?argument=value#anchor' )
			assert_equal( 'valid', media.url )
		end
	end

end # Providers
end # Essence
