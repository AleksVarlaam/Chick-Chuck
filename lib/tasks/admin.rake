# frozen_string_literal: true

namespace :admin do
  # Languages
  desc 'Start'
  task start: :environment do
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
      languages_array = %w[
        Русский Українська English עברית
      ]

      languages_array.each { |language| Language.create(title: language) }

      p "Created #{Language.count} languages"
    end
  end
end
