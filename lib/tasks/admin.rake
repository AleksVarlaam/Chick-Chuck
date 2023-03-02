# frozen_string_literal: true

namespace :admin do
  # Languages
  desc 'Languages'
  task languages: :environment do
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

  # Districts
  desc 'Districts'
  task districts: :environment do
    if District.exists?
      p 'Districts already exists!'
    else
      districts_array = [
        { ru: 'Весь Израиль',        en: 'All Israel',         uk: 'Весь Ізраїль',        he: 'כל ישראל' },
        { ru: 'Северный Округ',      en: 'Northern District',  uk: 'Північний Округ',     he: 'מחוז הצפון' },
        { ru: 'Центральный Округ',   en: 'Central District',   uk: 'Центральний округ',   he: 'מחוז המרכז' },
        { ru: 'Южный Округ',         en: 'Southern District',  uk: 'Південний Округ',     he: 'מחוז הדרומי' },
        { ru: 'Иерусалимский Округ', en: 'Jerusalem District', uk: 'Єрусалимський Округ', he: 'מחוז ירושלים' }
      ]

      districts_array.each { |dis| District.create(dis) }

      p "Created #{District.count} districts"
    end
  end

  # Catalog
  desc 'Catalog'
  task catalog: :environment do
    if Category.exists?
      p 'Catalog already exists!'
    else
      catalog_hash = [
        # Мебель
        { # Мебель для кухни
          name: { ru: 'Мебель для кухни', en: 'Kitchen furniture', uk: 'Кухонні меблі', he: 'Мебель для кухни' },
          things: [
            { ru: 'Кухни',            en: 'Kitchens',       uk: 'Кухні',          he: 'Кухни' },
            { ru: 'Диваны для кухни', en: 'Kitchen sofa',   uk: 'Кухонний диван', he: 'Диваны для кухни' },
            { ru: 'Стулья',           en: 'Chairs',         uk: 'Стільці',        he: 'Стулья' },
            { ru: 'Столы для кухни',  en: 'Kitchen table',  uk: 'Кухонний стіл',  he: 'Столы для кухни' },
            { ru: 'Обеденные группы', en: 'Dinner parties', uk: 'Обідні групи',   he: 'Обеденные группы' }
          ]
        },
        { # Мягкая мебель
          name: { ru: 'Мягкая мебель', en: 'Upholstered furniture', uk: "М'які меблі", he: 'Мягкая мебель' },
          things: [
            { ru: 'Диваны',              en: 'Sofas',                     uk: 'Дивани',                 he: 'Диваны' },
            { ru: 'Тахты',               en: 'Couches',                   uk: 'Кушети',                 he: 'Тахты' },
            { ru: 'Кресла',              en: 'Armchairs',                 uk: 'Крісла',                 he: 'Кресла' },
            { ru: 'Пуфы, банкетки',      en: 'Poufs, banquets',           uk: 'Пуфи, банкети',
              he: 'Пуфы, банкетки' },
            { ru: 'Набор мягкой мебели', en: 'Upholstered furniture set', uk: "Комплект м'яких меблів",
              he: 'Набор мягкой мебели' },
            { ru: 'Бескаркасная мебель', en: 'Frameless furniture',       uk: 'Безкорпусні меблі',
              he: 'Бескаркасная мебель' }
          ]
        },
        { # Корпусная мебель
          name: { ru: 'Корпусная мебель', en: 'Cabinet furniture', uk: 'Корпусні меблі', he: 'Корпусная мебель' },
          things: [
            { ru: 'Шкафы-купе',              en: 'Closets',               uk: 'Шафи',                he: 'Шкафы-купе' },
            { ru: 'Стенки',                  en: 'Wall',                  uk: 'Стінка',              he: 'Стенки' },
            { ru: 'Гардеробные',             en: 'Dressing rooms',        uk: 'Гардеробні',
              he: 'Гардеробные' },
            { ru: 'Распашные шкафы',         en: 'Swing cabinets',        uk: 'Распашные шкафы',
              he: 'Распашные шкафы' },
            { ru: 'Столы',                   en: 'Tables',                uk: 'Столи',               he: 'Столы' },
            { ru: 'Стеллажи',                en: 'Racks',                 uk: 'Стелажі',             he: 'Диваны' },
            { ru: 'Тумбы',                   en: 'Drawers',               uk: 'Тумби',               he: 'Тумбы' },
            { ru: 'Комоды',                  en: 'Racking',               uk: 'Комоди',              he: 'Комоды' },
            { ru: 'Трансформируемая мебель', en: 'Convertible furniture', uk: "Меблі 'Трансформер'",
              he: 'Трансформируемая мебель' }
          ]
        },
        { # Офисная мебель
          name: { ru: 'Офисная мебель', en: 'Office furniture', uk: 'Офісні меблі', he: 'Офисная мебель' },
          things: [
            { ru: 'Офисные столы',              en: 'Office Desks',                 uk: 'Офісні столи',
              he: 'Офисные столы' },
            { ru: 'Офисные стойки, ресепшн',    en: 'Office racks, reception desk', uk: 'Офісні стелажі, ресепшн',
              he: 'Офисные стойки, ресепшн' },
            { ru: 'Офисные шкафы',              en: 'Office cabinets',              uk: 'Офісні шафи',
              he: 'Офисные шкафы' },
            { ru: 'Офисные тумбы',              en: 'Office drawers',               uk: 'Офісні тумби',
              he: 'Офисные тумбы' },
            { ru: 'Офисные диваны',             en: 'Office sofas',                 uk: 'Офісні дивани',
              he: 'Офисные диваны' },
            { ru: 'Офисные кресла',             en: 'Office chairs',                uk: 'Офісні крісла',
              he: 'Бескаркасная мебель' },
            { ru: 'Офисные стулья',             en: 'Office seats',                 uk: 'Офісні стільці',
              he: 'Офисные стулья' },
            { ru: 'Мини-кухни для офиса',       en: 'Office kitchens',              uk: 'Офісні кухні',
              he: 'Мини-кухни для офиса' }
          ]
        },
        { # Детская мебель
          name: { ru: 'Детская мебель', en: 'Children’s furniture', uk: 'Дитячі меблі', he: 'Детская мебель' },
          things: [
            { ru: 'Шкафы для детской',          en: 'Cabinets',          uk: 'Дитячі шафи',
              he: 'Шкафы для детской' },
            { ru: 'Стеллажи для детской',       en: 'Racks',             uk: 'Дитячі стелажі',
              he: 'Стеллажи для детской' },
            { ru: 'Детские кровати',            en: 'Beds',              uk: 'Дитячі ліжка',
              he: 'Детские кровати' },
            { ru: 'Диваны для детской',         en: 'Sofas',             uk: 'Дитячі дивани',
              he: 'Диваны для детской' },
            { ru: 'Кроватки для новорожденных', en: 'Сots for newborns', uk: 'Дитячі ліжечка для немовлят',
              he: 'Кроватки для новорожденн' },
            { ru: 'Деткие столы',               en: 'Tables',            uk: 'Дитячі столи',
              he: 'Деткие столы' },
            { ru: 'Детские стулья',             en: 'Seats',             uk: 'Дитячі стільці',
              he: 'Детские стулья' },
            { ru: 'Стульчики для кормления',    en: 'Feeding chairs',    uk: 'Дитячі стільці для годування',
              he: 'Стульчики для кормления' },
            { ru: 'Пеленальные комоды',         en: 'Changing cabinets', uk: 'Пеленальні комоди',
              he: 'Пеленальные комоды' }
          ]
        },
        { # Мебель для спальни
          name: { ru: 'Мебель для спальни', en: 'Bedroom furniture', uk: 'Меблі для спальні',
                  he: 'Мебель для спальни' },
          things: [
            { ru: 'Кровати',                  en: 'Bed',                uk: 'Ліжка', he: 'Кровати' },
            { ru: 'Спальные гарнитуры',       en: 'Bedroom set',        uk: 'Спальні гарнітури',
              he: 'Спальные гарнитуры' },
            { ru: 'Матрасы',                  en: 'Mattress',           uk: 'Матрац', he: 'Матрасы' },
            { ru: 'Ортопедические основания', en: 'Orthopedic grounds', uk: 'Ортопедичні підстави',
              he: 'Ортопедические основания' },
            { ru: 'Подушки',                  en: 'Pillow',             uk: 'Подушка', he: 'Подушки' },
            { ru: 'Прикроватные тумбы',       en: 'Bedside cabinets',   uk: 'Тумби',
              he: 'Прикроватные тумбы' }
          ]
        },
        { # Мебель из массива
          name: { ru: 'Мебель из массива', en: 'Solid furniture', uk: 'Деревʼяні меблі', he: 'Мебель из массива' },
          things: [
            { ru: 'Столы из массива',         en: 'Array tables',           uk: 'Деревʼяні столи',
              he: 'Столы из массива' },
            { ru: 'Кровати из массива',       en: 'Bed array',              uk: 'Деревʼяні ліжка',
              he: 'Кровати из массива' },
            { ru: 'Наборы мебели из массива', en: 'Solid Furniture Sets',   uk: 'Деревʼяні меблі Sets',
              he: 'Наборы мебели из массива' },
            { ru: 'Шкафы из массива',         en: 'Solid Case Cabinets',    uk: 'Суцільні шафи',
              he: 'Шкафы из массива' },
            { ru: 'Стеллажи из массива',      en: 'Solid Shelving',         uk: 'Суцільні шельфування',
              he: 'Стеллажи из массива' },
            { ru: 'Буфеты из массива',        en: 'Buffets from the array', uk: 'Деревєяні шафи',
              he: 'Буфеты из массива' },
            { ru: 'Тумбы  из массива',        en: 'Array cabinets',         uk: 'Деревʼяні комоди',
              he: 'Тумбы  из массива' },
            { ru: 'Комоды из массива',        en: 'Array chest of drawers', uk: 'Комоды из массива',
              he: 'Комоды из массива' },
            { ru: 'Лестницы из массива ',     en: 'Array ladder',           uk: 'Деревʼяні сходи',
              he: 'Лестницы из массива ' }
          ]
        },
        { # Садовая мебель
          name: { ru: 'Садовая мебель', en: 'Garden furniture', uk: 'Садові меблі', he: 'Садовая мебель' },
          things: [
            { ru: 'Кованая мебель',     en: 'Forged furniture',   uk: 'Ковані меблі',         he: 'Кованая мебель' },
            { ru: 'Мебель для отдыха',  en: 'Vacation furniture', uk: 'Меблі для відпочинку', he: 'Мебель для отдыха' },
            { ru: 'Плетеная мебель',    en: 'Wicker furniture',   uk: 'Плетені меблі',        he: 'Плетеная мебель' },
            { ru: 'Пластиковая мебель', en: 'Plastic furniture',  uk: 'Пластикові меблі',
              he: 'Пластиковая мебель' }
          ]
        },
        { # Двери
          name: { ru: 'Двери', en: 'Door', uk: 'Двері', he: 'Двери' },
          things: [
            { ru: 'Перегородки',        en: 'Partitions',     uk: 'Перегородки',     he: 'Перегородки' },
            { ru: 'Входные двери',      en: 'Front door',     uk: 'Вхідні двері',    he: 'Входные двери' },
            { ru: 'Межкомнатные двери', en: 'Interior doors', uk: 'Внутрішні двері', he: 'Межкомнатные двери' }
          ]
        },
        { # Комплектующие для мебели
          name: { ru: 'Комплектующие для мебели', en: 'Furniture accessories', uk: 'Фурнітура для меблів',
                  he: 'Комплектующие для мебели' },
          things: [
            { ru: 'Столешницы, барные стойки', en: 'Countertops, bar counters', uk: 'Барні стійки',
              he: 'Столешницы, барные стойки' },
            { ru: 'Мебельные фасады',          en: 'Furniture facades',         uk: 'Меблеві фасади',
              he: 'Мебельные фасады' },
            { ru: 'Фурнитура',                 en: 'Accessories',               uk: 'Аксесуари', he: 'Фурнитура' },
            { ru: 'Мойки, раковины',           en: 'Sinks',                     uk: 'Раковини',
              he: 'Мойки, раковины' }
          ]
        },
        { # Предметы интерьера
          name: { ru: 'Предметы интерьера', en: 'Interior', uk: "Інтер'єр", he: 'Предметы интерьера' },
          things: [
            { ru: 'Зеркала',            en: 'Looking glass',   uk: 'Дзеркало',        he: 'Зеркала' },
            { ru: 'Вешалки',            en: 'Coat hangers',    uk: 'Вішаки',          he: 'Вешалки' },
            { ru: 'Настенные полки',    en: 'Wall shelves',    uk: 'Полиця',          he: 'Настенные полки' },
            { ru: 'Вазоны, цветочницы', en: 'Vases, florists', uk: 'Вази',            he: 'Вазоны, цветочницы' },
            { ru: 'Камины',             en: 'Fire place',      uk: 'Каміни',          he: 'Камины' },
            { ru: 'Элементы декора',    en: 'Decor elements',  uk: 'Елементи декору', he: 'Элементы декора' }
          ]
        },
        # Бытовая техника
        { # Бытовая техника для кухни
          name: { ru: 'Бытовая техника для кухни', en: 'Kitchen appliances', uk: 'Кухонна техніка',
                  he: 'Бытовая техника для кухни' },
          things: [
            { ru: 'Холодильники до 100 л.',            en: 'Refrigerators up to 100 liters',
              uk: 'Холодильники до 100 л.',            he: 'Холодильники до 100 л.' },
            { ru: 'Холодильники 200-300 л.',           en: 'Refrigerators 200-300 liters',
              uk: 'Холодильники 200-300 л.',           he: 'Холодильники 200-300 л.' },
            { ru: 'Холодильники 300-500 л.',           en: 'Refrigerators 300-500 liters',
              uk: 'Холодильники 300-500 л.',           he: 'Холодильники 300-500 л.' },
            { ru: 'Холодильники свыше 500 л.',         en: 'Refrigerators over 500 liters',
              uk: 'Холодильники понад 500 л.',         he: 'Холодильники свыше 500 л.' },
            { ru: 'Встраиваемые духовые шкафы',        en: 'Built-in oven',
              uk: 'Вбудована духовка',                 he: 'Встраиваемые духовые шкафы' },
            { ru: 'Плиты',                             en: 'Plate',
              uk: 'Плита',                             he: 'Встраиваемые духовые шкафы' },
            { ru: 'Микроволновые печи, электропечи',   en: 'Microwave ovens, electric ovens',
              uk: 'Мікрохвильові, електричні печі',    he: 'Микроволновые печи, электропечи' },
            { ru: 'Кухонные комбайны, измельчители',   en: 'Kitchen harvesters, shredders',
              uk: 'Кухонні комбайни, подрібнювачі',    he: 'Кухонные комбайны, измельчители' },
            { ru: 'Пароварки',                         en: 'Steamer',
              uk: 'Пароварка',                         he: 'Пароварки' },
            { ru: 'Миксеры',                           en: 'Mixers',
              uk: 'Змішувачі',                         he: 'Миксеры' },
            { ru: 'Аэрогрили',                         en: 'Airgrills',
              uk: 'Аиргриллес',                        he: 'Аэрогрили' },
            { ru: 'Электрогрили',                      en: 'Electric grills',
              uk: 'Електричні грилі',                  he: 'Электрогрили' },
            { ru: 'Вафельницы, блинницы, сэндвичницы', en: 'Waffle irons, pancakes, sandwiches',
              uk: 'Вафельниці, млинниці, тостери',     he: 'Вафельницы, блинницы, сэндвичницы' },
            { ru: 'Сушилки для овощей и фруктов',      en: 'Vegetable and Fruit Dryers',
              uk: 'Овочеві і фруктові дрієри',         he: 'Сушилки для овощей и фруктов' },
            { ru: 'Встраиваемые рабочие поверхности',  en: 'Embedded work surfaces',
              uk: 'Вбудовані робочі поверхні',         he: 'Встраиваемые рабочие поверхности' },
            { ru: 'Вытяжки',                           en: 'Extracts',
              uk: 'Витяжки',                           he: 'Вытяжки' },
            { ru: 'Посудомоечные машины',              en: 'Dishwashers',
              uk: 'Посудомийні машини',                he: 'Посудомоечные машины' },
            { ru: 'Электрочайники и термопоты',        en: 'Electric kettles and thermopots',
              uk: 'Електричні чайники і термоси',      he: 'Электрочайники и термопоты' },
            { ru: 'Мясорубки',                         en: 'Meat grinder',
              uk: "М'ясорубка",                        he: 'Мясорубки' },
            { ru: 'Хлебопечки, тостеры',               en: 'Bread presses, toasters',
              uk: 'Хлібопічки',                        he: 'Хлебопечки, тостеры' },
            { ru: 'Ломтерезки',                        en: 'Slicery',
              uk: 'Слікері',                           he: 'Ломтерезки' },
            { ru: 'Йогуртницы и мороженицы',           en: 'Yogurts and Ice Creams',
              uk: 'Йогуртниці та морожениці',          he: 'Йогуртницы и мороженицы' },
            { ru: 'Измельчители пищевых отходов',      en: 'Food Waste Disposal',
              uk: 'Утилізація харчових відходів',      he: 'Измельчители пищевых отходов' },
            { ru: 'Маринаторы',                        en: 'Marinators',
              uk: 'Маринатори',                        he: 'Маринаторы' },
            { ru: 'Кофеварки и кофемашины',            en: 'Coffeemakers',
              uk: 'Кофемолки',                         he: 'Кофеварки и кофемашины' },
            { ru: 'Кофемолки',                         en: 'Coffee grinder',
              uk: 'Кавоварки',                         he: 'Кофемолки' },
            { ru: 'Мультиварки',                       en: 'Crock-pot',
              uk: 'Мультиварки',                       he: 'Мультиварки' },
            { ru: 'Соковыжималки',                     en: 'Juicers',
              uk: 'Соковижималки',                     he: 'Соковыжималки' },
            { ru: 'Винные шкафы',                      en: 'Wine cabinets',
              uk: 'Винні шафи',                        he: 'Винные шкафы' },
            { ru: 'Фритюрницы',                        en: 'Deep fryer',
              uk: 'Фритюрниці',                        he: 'Фритюрницы' }
          ]
        },
        { # Бытовая техника для дома
          name: { ru: 'Бытовая техника для дома', en: 'Home appliances', uk: 'Побутова техніка',
                  he: 'Бытовая техника для дома' },
          things: [
            { ru: 'Стиральные машины',      en: 'Washing machine',                   uk: 'Пральні машини',
              he: 'Стиральные машины' },
            { ru: 'Сушильные машины',       en: 'Drying machines',                   uk: 'Сушильні машини',
              he: 'Сушильные машины' },
            { ru: 'Все для кройки и шитья', en: 'Everything for cutting and sewing', uk: 'Все для шиття',
              he: 'Все для кройки и шитья' },
            { ru: 'Пылесосы',               en: 'Vacuum cleaners',                   uk: 'Пилососи',
              he: 'Пылесосы' }
          ]
        },
        { # Климатическое оборудование
          name: { ru: 'Климатическое оборудование', en: 'Climatic equipment', uk: 'Кліматичне обладнання',
                  he: 'Климатическое оборудование' },
          things: [
            { ru: 'Кондиционеры, тепловые завесы',    en: 'Air conditioners, thermal curtains',
              uk: 'Кондиціонери',                             he: 'Кондиционеры, тепловые завесы' },
            { ru: 'Обогреватели и электрокамины',     en: 'Heaters and electric fireplaces',
              uk: 'Обігрівачі та електричні каміни',          he: 'Обогреватели и электрокамины' },
            { ru: 'Тепловые пушки',                   en: 'Heat guns',
              uk: 'Теплові пушки',                            he: 'Тепловые пушки' },
            { ru: 'Водоногреватели',                  en: 'Water heater',
              uk: 'Водонагрівач',                             he: 'Водоногреватели' },
            { ru: 'Очистители и увлажнители воздуха', en: 'Air purifiers and humidifiers',
              uk: 'Очищувачі повітря та зволожувачі повітря', he: 'Очистители и увлажнители воздуха' },
            { ru: 'Вентиляторы',                      en: 'Fans',
              uk: 'Вентиляторы',                              he: 'Вентиляторы' }
          ]
        }
      ]

      catalog_hash.each do |category|
        Category.create(category[:name])
        category[:things].each { |thing| Category.find_by(ru: category[:name][:ru].to_s).things.create(thing) }
      end

      p "Created #{Category.count} categories and #{Thing.count} things"
    end
  end
end
