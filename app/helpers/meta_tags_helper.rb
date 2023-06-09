# frozen_string_literal: true

module MetaTagsHelper
  def default_meta_tags
    {
      viewport: 'width=device-width,initial-scale=1',
      site: 'Chick-Chuck.com',
      reverse: true,
      separator: '|',
      description: t('home_page.h2'),
      keywords: "#{t('company.carriers')}, #{t('moving_preparation.title')}, #{t('moving')}, #{t('pages.market')}",
      canonical: request.original_url,
      noindex: !Rails.env.production?,
      icon: [
        { href: image_url(asset_path('icons/chick-chuck/chick-chuck-logo.png')) },
        { href: image_url(asset_path('icons/chick-chuck/chick-chuck-logo.png')), rel: 'apple-touch-icon',
          sizes: '180x180', type: 'image/jpg' }
      ],
      og: {
        title: :title,
        site_name: 'Chick-Chuck.com',
        description: t('home_page.h2'),
        type: 'website',
        url: request.original_url,
        image: image_url(asset_path('icons/chick-chuck/chick-chuck-logo.png'))
      },
      author: 'Aleksandr Varlamov',
      'google-site-verification' => 'google-site-verification=toUojvLJpY342LZjZXWqyfs2Mw4ne0xuoljh2V1QgHw',
      'geo.position' => '31.4117257;35.0818155',
      'geo.region' => 'IL',
      'geo.placename' => 'Israel'
    }
  end
end
