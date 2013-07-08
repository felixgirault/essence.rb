#
#	AUTHOR Félix Girault <felix.girault@gmail.com>
#	LICENCE FreeBSD License (http://opensource.org/licenses/BSD-2-Clause)
#

require_relative 'providers/o_embed'



#
#
#

{
	'Dailymotion' => {
		'class' => 'OEmbed',
		'pattern' => '#dailymotion\.com#i',
		'endpoint' => 'http://www.dailymotion.com/services/oembed?format=json&url=%s',
		'format' => OEmbed::json
	},
	'Vimeo' => {
		'class' => 'OEmbed',
		'pattern' => '#vimeo\.com#i',
		'endpoint' => 'http://vimeo.com/api/oembed.json?url=%s',
		'format' => OEmbed::json,
		'prepare' => lambda { | url |

			# Refactors URLs like these :
			# - http://player.vimeo.com/video/20830433
			# in such form :
			# - http://www.vimeo.com/20830433

			url = Essence::Providers::OEmbed::prepare( url )
			matches = /player\.vimeo\.com\/video\/(?<id>[0-9]+)/i.match( url )

			if !matches.is_nil?
				url = 'http://www.vimeo.com/' + matches[ :id ]
			end

			return url
		}
	},
	'Youtube' => {
		'class' => 'OEmbed',
		'pattern' => /youtube\.com|youtu\.be/i,
		'endpoint' => 'http://www.youtube.com/oembed?format=json&url=%s',
		'format' => Essence::Providers::OEmbed::json,
		'prepare' => lambda { | url |

			# Refactors URLs like these :
			# - http://www.youtube.com/watch?v=oHg5SJYRHA0&noise=noise
			# - http://www.youtube.com/v/oHg5SJYRHA0
			# - http://www.youtube.com/embed/oHg5SJYRHA0
			# - http://youtu.be/oHg5SJYRHA0
			# in such form :
			# - http://www.youtube.com/watch?v=oHg5SJYRHA0

			url = Essence::Providers::OEmbed::prepare( url )
			matches = /(?:v=|v/|embed/|youtu\.be/)(?<id>[a-z0-9_-]+)/i.match( url )

			if !matches.is_nil?
				url = 'http://www.youtube.com/watch?v=' + matches[ :id ]
			end

			return url
		}
	}

	#	'OEmbed' => {
	#		'class' => 'OEmbed',
	#		'pattern' => /.*/
	#	},

	#	'OpenGraph' => {
	#		'class' => 'OpenGraph',
	#		'pattern' => /.*/
	#	}
}
