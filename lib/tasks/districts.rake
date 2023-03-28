namespace :districts do
  
  # Districts
  desc 'Start'
  task start: :environment do
    if District.exists?
      p 'Districts already exists!'
    else
      districts_hash = [
        {
          name: { ru: 'Весь Израиль',          en: 'All Israel',                 uk: 'Весь Ізраїль',         he: 'כל ישראל' },
        },
        { name: { ru: 'Северный Округ',        en: 'Northern District',          uk: 'Північний Округ',      he: 'מחוז הצפון‏' },
          cities: [
            { ru: 'Акко',        en: 'Acre',          uk: 'Акра',      he: 'עכו‏' }
          ]
        },
        {
          name: { ru: 'Хайфский округ',        en: 'Haifa District',             uk: 'Хайфський округ',      he: 'מחוז חיפה' },
          cities: [
            {}
          ]
        },
        {
          name: { ru: 'Тель-Авивский округ',   en: 'Tel-Aviv District',          uk: 'Тель-Авівський Округ', he: 'מחוז תל אביב‏‏' },
          cities: [
            {}
          ]
        },
        {
          name: { ru: 'Центральный Округ',     en: 'Central District',           uk: 'Центральний округ',    he: 'מחוז המרכז‏' },
          cities: [
            {}
          ]
        },
        {
          name: { ru: 'Иерусалимский округ',   en: 'Jerusalem District',         uk: 'Єрусалимський округ',  he: 'מחוז ירושלים‏‏' },
          cities: [
            {}
          ]
        },
        {
          name: { ru: 'Южный Округ',           en: 'Southern District',          uk: 'Південний Округ',      he: 'מחוז הדרום' },
          cities: [
            {}
          ]
        },
        {
          name: { ru: 'Округ Иудея и Самария', en: 'Judea and Samaria District', uk: 'Округ Юдея і Самарія', he: 'מחוז יהודה ושומרון' },
          cities: [
            {}
          ]
        }
      ]

      districts_hash.each do |district|
        District.create(district[:name])
        district[:cities].each { |city| District.find_by(en: district[:name][:en].to_s).cities.create(city) } if district[:cities].present?
      end

      p "Created #{District.count} districts and #{City.count} cities"
    end
  end
  
end