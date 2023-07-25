# frozen_string_literal: true

module MetaTagsHelper
  def default_meta_tags
    {
      charset: 'utf-8',
      site: 'Chick-Chuck.com',
      reverse: true,
      separator: '|',
      keywords: "#{t('company.carriers')}, #{t('moving_preparation.title')}, #{t('moving')}, #{t('pages.market')},  #{Service.all.decorate.map(&:title).join(', ').sub(
        /(, )+$/, ''
      )}",
      canonical: request.original_url,
      noindex: !Rails.env.production?,
      manifest: '/manifest.webmanifest',
      og: {
        title: :title,
        site_name: 'Chick-Chuck.com',
        description: :description,
        type: 'website',
        url: request.original_url,
        image: [image_url('logo/og-chick-chuck.png'), image_url('logo/og-chick-chuck-sm.png')]
      },
      fb: {
        app_id: '2318377664996656'
      },
      author: 'Aleksandr Varlamov',
      'geo.position' => '31.4117257;35.0818155',
      'geo.region' => 'IL',
      'geo.placename' => 'Israel'
    }
  end
end
