#
#	AUTHOR Félix Girault <felix.girault@gmail.com>
#	LICENCE FreeBSD License (http://opensource.org/licenses/BSD-2-Clause)
#

require 'test/unit'
require_relative '../lib/media'

module Essence

	#
	#
	#

	class MediaTest < Test::Unit::TestCase

		#
		#
		#

		def setup

			@media = Essence::Media.new({ 'property' => 'value' })
		end



		#
		#
		#

		def test_has?

			assert( @media.has?( 'property' ))
		end



		#
		#
		#

		def test_get

			assert_equal( 'value', @media.get( 'property' ))
			assert_equal( 'default', @media.get( 'other_property', 'default' ))

			assert_equal( 'value', @media[ 'property' ])
		end



		#
		#
		#

		def test_set

			@media.set( 'other_property', 'value' )
			assert_equal( 'value', @media.get( 'other_property' ))

			@media[ 'third_property' ] = 'value'
			assert_equal( 'value', @media.get( 'third_property' ))
		end
	end

end # Essence
