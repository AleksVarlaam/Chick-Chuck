# frozen_string_literal: true

namespace :admin do
  # Languages
  desc 'Start'
  task start: :environment do
    # Create Admin
    if Admin.exists?
      p 'Admin already exists!'
    else
      Admin.create(email: 'aleksvarlaam@gmail.com', password: '1UhsX7Rp', password_confirmation: '1UhsX7Rp',
                   phone: '+972537013915', confirmed_at: Time.now)
    end

    # Statistic
    if Statistic.exists?
      p 'Statistic already exists!'
    else
      Statistic.create
      p 'Statistic created'
    end

    # Languages
    if Language.exists?
      p 'Languages already exists!'
    else
      languages_array = %w[עברית عربي አማርኛ]

      languages_array += %w[
        English Русский Українська Français Español Italiano
      ]

      languages_array.each { |language| Language.create(title: language) }

      p "Created #{Language.count} languages"
    end
  end
end
