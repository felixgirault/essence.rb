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

			@config = {
				'Dailymotion' => {
					:class => 'OEmbed::Dailymotion',
					:pattern => /dailymotion\.com/i,
					:endpoint => 'http://www.dailymotion.com/services/oembed?format=json&url=%s',
					:format => 'json'
				},
				'Vimeo' => {
					:class => 'OEmbed::Vimeo',
					:pattern => /vimeo\.com/i,
					:endpoint => 'http://vimeo.com/api/oembed.json?url=%s',
					:format => 'json'
				},
				'Youtube' => {
					:class => 'OEmbed',
					:pattern => /youtube\.com|youtu\.be/i,
					:endpoint => 'http://www.youtube.com/oembed?format=json&url=%s',
					:format => 'json'
				}
			}.merge( config )
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

			providers = [ ]

			@config.each do | name, options |
				if ( url =~ options[ :pattern ])
					providers.push( self._provider( name, options ))
				end
			end

			providers
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
