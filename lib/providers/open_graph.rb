#
#	AUTHOR Félix Girault <felix.girault@gmail.com>
#	LICENCE FreeBSD License (http://opensource.org/licenses/BSD-2-Clause)
#

module Essence
module Providers

	#
	#
	#

	class OpenGraph < Provider

	protected

		#
		#
		#

		def _embed( )

			og = self._extract_informations( url )

			if ( og.empty? )
				raise Error.new(
					'Unable to extract OpenGraph data.'
				)
			end

			return Media.new(
				Set::reindex( og, {
					'og:type' => 'type',
					'og:title' => 'title',
					'og:description' => 'description',
					'og:site_name' => 'provider_name',
					'og:image' => 'thumbnail_url',
					'og:image:url' => 'thumbnail_url',
					'og:image:width' => 'width',
					'og:image:height' => 'height',
					'og:video:width' => 'width',
					'og:video:height' => 'height',
					'og:url' => 'url'
				})
			)
		end



		#
		#	Extracts OpenGraph informations from the given URL.
		#

		def _extract_informations( url )

			@_extract_informations ||= { }
			@_extract_informations[ url ] ||= (

				attributes = Registry::get( 'dom' ).extract_attributes(
					HTTP.get( URI( url )), {
						'meta' => {
							'property' => '#^og:.+#i',
							'content'
						}
					}
				)

				og = { }

				attributes['meta'].each do | meta |
					if ( og.include?( meta['property']))
						og[ meta['property']] = meta['content']
					end
				end

				if ( !og.include?( 'html' ))
					og['html'] = self._build_HTML( og, url )
				end

				og
			)
		end



		#
		#	Builds an HTML code from OpenGraph properties.
		#

		def _build_HTML( og, url )

			title = og['og:title'] || ''
			html = ''

			if ( og.include?( 'og:video' ))
				html = '<iframe src="%{url}" alt="%{title}" width="%{width}" height="%{height}" frameborder="0" allowfullscreen mozallowfullscreen webkitallowfullscreen></iframe>' % {
					'url' => og['og:video'],
					'title' => title,
					'width' => og['og:video:width'] || 560,
					'height' => og['og:video:height'] || 315
				}
			else
				html = '<a href="%{url}" alt="%{title}">%{title}</a>' % {
					'url' => og['og:url'] || url,
					'title' => title
				}
			end

			html
		end
	end

end # Providers
end # Essence
