# frozen_string_literal: true

namespace :admin do
  # Languages
  desc 'Start'
  task start: :environment do
    # Create Admin
    unless Admin.exists?
      Admin.create(email: 'aleksvarlaam@gmail.com', password: '1UhsX7Rp', password_confirmation: '1UhsX7Rp', 
                   phone: '+972537013915', confirmed_at: Time.now)
    else
      p 'Admin already exists!'
    end
    
    # Statistic
    unless Statistic.exists?
      Statistic.create
      p 'Statistic created'
    else
      p 'Statistic already exists!'
    end

    # Languages
    unless Language.exists?
      languages_array = %w[
        Русский Українська English עברית
      ]

      languages_array.each { |language| Language.create(title: language) }

      p "Created #{Language.count} languages"
    else
      p 'Languages already exists!'
    end
  end
end
