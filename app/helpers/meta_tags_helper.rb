# frozen_string_literal: true

module MetaTagsHelper
  def default_meta_tags
    {
      charset: 'utf-8',
      site: 'Chick-Chuck.com',
      reverse: true,
      separator: '|',
      keywords: "#{t('company.carriers')}, #{t('moving_preparation.title')}, #{t('moving')}, #{t('pages.market')}",
      canonical: request.original_url,
      noindex: !Rails.env.production?,
      manifest: '/manifest.webmanifest',
      icon: [
        {
          href: image_url(asset_path('favicon.svg')), rel: 'icon', type: 'image/svg+xml'
        },
        {
          href: image_url(asset_path('favicon.ico')), rel: 'icon', sizes: 'any', type: 'image/x-icon'
        },
        {
          href: image_url(asset_path('android-chrome-512x512.png')), rel: 'icon',
          sizes: '512x512', type: 'image/png'
        },
        {
          href: image_url(asset_path('apple-touch-icon.png')), rel: 'apple-touch-icon',
          sizes: '180x180', type: 'image/png'
        }

      ],
      og: {
        title: :title,
        site_name: 'Chick-Chuck.com',
        description: :description,
        type: 'website',
        url: request.original_url,
        image: {
          url: image_url(asset_path('icons/chick-chuck/og-chick-chuck.png')),
          type: 'image/png'
        }
      },
      fb: {
        app_id: '2318377664996656'
      },
      author: 'Aleksandr Varlamov',
      'google-site-verification' => 'google-site-verification=toUojvLJpY342LZjZXWqyfs2Mw4ne0xuoljh2V1QgHw',
      'geo.position' => '31.4117257;35.0818155',
      'geo.region' => 'IL',
      'geo.placename' => 'Israel'
    }
  end
end
