# frozen_string_literal: true
# Preview all emails at http://localhost:3000/rails/mailers/company_mailer/example.html

module Mailers
  class CompanyMailer < ApplicationMailer

    def message_template(user, subject, main_content)
      @h1 = "Привет #{user.user_name} 👋🏻"
      @main_content = main_content
      
      mail to: user.email, 
           subject: subject
    end
  
    def sending
      subject = 'Обновление'
      main_content = "На сайте произошло небольшое обновление, пожалуйста, обновите информацию о вашей компании в личном кабинете для более лучшего отображения вашего профиля на сайте. <br> Конкретнее: <br> - Загрузите заново ваш логотип для более качественного отображения; <br> - Укажите категории услуг, которые вы оказываете. <br> - Обновите или добавьте пункт 'Описание или слоган' используя добавленный текстовый редактор."
      
      User.where.not(type: 'Client').each do |user| 
        Mailers::CompanyMailer.message_template(user, subject, main_content).deliver_later 
      end
    end
    
    def test_sending
      subject = 'Обновление'
      main_content = "На сайте произошло небольшое обновление, пожалуйста, обновите информацию о вашей компании в личном кабинете для более лучшего отображения вашего профиля на сайте. <br> Конкретнее: <br> - Загрузите заново ваш логотип для более качественного отображения; <br> - Укажите категории услуг, которые вы оказываете. <br> - Обновите или добавьте пункт 'Описание или слоган' используя добавленный текстовый редактор."
      
      Mailers::CompanyMailer.message_template(Admin.first, subject, main_content).deliver_now 
    end
  end
end