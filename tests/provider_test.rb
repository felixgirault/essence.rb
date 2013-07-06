#
#	AUTHOR Félix Girault <felix.girault@gmail.com>
#	LICENCE FreeBSD License (http://opensource.org/licenses/BSD-2-Clause)
#

require 'test/unit'
require_relative '../lib/media'
require_relative '../lib/provider'

module Essence

	#
	#
	#

	class ConcreteProvider < Essence::Provider

	protected

		#
		#
		#

		def _embed( url, options )

			Essence::Media.new({ 'title' => 'Title' })
		end
	end



	#
	#
	#

	class ProviderTest < Test::Unit::TestCase

		#
		#
		#

		def test_embed

			provider = ConcreteProvider.new( )
			expected = Essence::Media.new({
				'title' => 'Title',
				'url' => 'http://foo.bar'
			})

			result = provider.embed( '  http://foo.bar  ' )

			assert( expected.properties == result.properties )
		end
	end

end # Essence
