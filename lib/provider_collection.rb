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
		#	Loads the given providers.
		#

		def initialize( config = { })

			@config = case
				when config.is_a?( String )	self.load( @config )
				when config.is_a?( Hash )	config
				else { }
			end
		end



		#
		#
		#

		def load( filename )

			proc = Proc.new
			eval( File.read( filename ), proc.binding, filename )
		end



		#
		#	Tells if a provider was found for the given url.
		#

		def has_provider?( url )

			@config.each do | options |
				if ( url =~ options[ :pattern ])
					return true
				end
			end

			false
		end



		#
		#	Finds providers of the given url.
		#

		def providers( url )

			@config.each do | name, options |
				if ( url =~ options[ :pattern ])
					yield self._provider( name, options )
				end
			end
		end

	protected

		#
		#	Lazy loads a provider given its name and configuration.
		#

		def _provider( name, options )

			@_provider ||= { }
			@_provider[ name ] ||= (

				Object::const_get( name ).new( options )
			)
		end
	end

end # Essence
