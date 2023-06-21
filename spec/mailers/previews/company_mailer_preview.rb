# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/company_mailer/example.html

class CompanyMailerPreview < ActionMailer::Preview

  def message_template
    subject = 'Обновление'
    main_content = "На сайте произошло небольшое обновление, пожалуйста, обновите информацию о вашей компании в личном кабинете для более лучшего отображения вашего профиля на сайте. <br> Конкретнее: <br> - Загрузите заново ваш логотип для более качественного отображения; <br> - Укажите категории услуг, которые вы оказываете. <br> - Обновите или добавьте пункт 'Описание или слоган' используя добавленный текстовый редактор."
    
    Mailers::CompanyMailer.message_template(Company.first, subject, main_content)
  end
end
