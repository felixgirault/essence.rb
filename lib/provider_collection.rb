#
module Essence



#
class ProviderCollection

	#
	def initialize( providers = [ ])

		@providers = [ ]

		load( providers )
	end



	#
	def load( providers = [ ])



		Dir[ ].each { |file| require File.basename( file ) }
	end



	#
	def has( url )

		@providers.find { |provider| provider.canEmbed( url ) }
	end
end

end # module
