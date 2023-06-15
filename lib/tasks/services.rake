# frozen_string_literal: true

namespace :services do
  # Languages
  desc "Start"
  task start: :environment do
    # Create Admin
    if Service.exists?
      p "Service already exists!"
    else
      services_array = [
          { ru: "Пассажирские перевозки/трансфер", en: "Passenger transport/transfer",  uk: "Пасажирський транспорт/трансфер", 
            he: "העברה/הובלה של נוסעים" },
          { ru: "Курьерские доставки",             en: "Courier service",               uk: "Кур'єрська служба", 
            he: "שירות שליחים" },
          { ru: "Перевозки квартир/домов",         en: "Carriage of apartments/houses", uk: "Перевезення квартир/будинків", 
            he: "השכרת דירות / דירות" },
          { ru: "Перевозки офисов",                en: "Office haulage",                uk: "Офісні перевезення", 
            he: "משרד התחבורה" },
          { ru: "Сборка и разборка",               en: "Assembly and disassembly",      uk: "Збірка і розбирання", 
            he: "הרכבה ופירוק" },
          { ru: "Упаковка вещей",                  en: "Packing",                       uk: "Упаковка речей", 
            he: "אריזה של דברים" },
          { ru: "Складирование вещей",             en: "Warehousing",                   uk: "Складування", 
            he: "מחסן" },
          { ru: "Подъёмный кран",                  en: "Crane(manof)",                  uk: "Кран", 
            he: "העגור" },
          { ru: "Аренда грузовика с водителем",    en: "Driver truck rental",           uk: "Оренда вантажівки водія", 
            he: "השכרת משאית נהג" },
          { ru: "Вывоз мусора",                    en: "Garbage removal",               uk: "Вивезення сміття", 
            he: "איסוף אשפה" }
      ]
      
      services_array.each do |service|
        Service.create(service)
      end
      
      p "Created #{Service.count} services"
    end

    
  end
end
