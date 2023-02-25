namespace :admin do
  # Languages
  desc "Languages"
  task languages: :environment do
    unless Language.exists?
      languages_array = [
        'Русский', 'Українська', 'English', 'עברית'
      ]

      languages_array.each { |language|  Language.create(title: language) }
      
      p "Created #{Language.count} languages"
    else
      p "Languages already exists!"
    end
  end

  # Districts
  desc "Districts"
  task districts: :environment do
    unless District.exists?
      districts_array = [
        {ru: 'Весь Израиль', en: 'All Israel', uk: 'Весь Ізраїль', he: 'כל ישראל'},
        {ru: 'Северный Округ', en: 'Northern District', uk: 'Північний Округ', he: 'מחוז הצפון'},
        {ru: 'Центральный Округ', en: 'Central District', uk: 'Центральний округ', he: 'מחוז המרכז'},
        {ru: 'Южный Округ', en: 'Southern District', uk: 'Південний Округ', he: 'מחוז הדרומי'},
        {ru: 'Иерусалимский Округ', en: 'Jerusalem District', uk: 'Єрусалимський Округ', he: 'מחוז ירושלים'}
      ]

      districts_array.each { |dis| District.create(dis) }
      
      p "Created #{District.count} districts"
    else
      p "Districts already exists!"
    end
  end
  
  # Catalog
  desc "Catalog"
  task catalog: :environment do
    unless Category.exists?
      catalog_hash = [
        { # Мебель
          name: {ru: 'Мебель', en: 'Furnitures', uk: 'Меблі', he: 'רהיט'},
          things: [
            {ru: 'Диван', en: 'Sofa', uk: 'Меблі', he: 'רהיט'},
            {ru: 'Кресло', en: 'Chair', uk: 'Кресло', he: 'Chair'}
          ]
        },
        { # Техника
          name: {ru: 'Техника', en: 'Technikue', uk: 'Техника', he: 'Техника'},
          things: [
            {ru: 'Freezer', en: 'Freezer', uk: 'Freezer', he: 'Freezer'},
            {ru: 'TV', en: 'TV', uk: 'TV', he: 'TV'}
          ]
        }
      ]
    
      catalog_hash.each do |category|
        Category.create(category[:name])
        category[:things].each {|thing| Category.find_by(en: category[:name][:en].to_s).things.create(thing) }
      end
      
      p "Created #{Category.count} categories and #{Thing.count} things"
    else
      p "Catalog already exists!"
    end
  end
end
