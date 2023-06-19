# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/company_mailer/example.html

class CompanyMailerPreview < ActionMailer::Preview

  def message_template
    subject = 'Обновление'
    main_content = "Количество перевозчиков в сервисе постепенно растет и чтобы клиенту было удобнее вас найти, теперь вы можете указать категории услуг, которые вы оказываете, для этого вам нужно перейти по вкладке 'О компании' в личном кабинете и добавить информацию в разделе услуги. Так же, теперь вы можете загрузить фотографии для вашего портфолио, например, ваш автопарк и вашу команду, перейдя по вкладке 'Галерея' в вашем личном кабинете. <br> Заходите в личный кабинет и обновляйте информацию о вашей компании, чтобы выделиться среди других перевозчиков и привлечь своего потенциального клиента!"
    
    Mailers::CompanyMailer.message_template(Company.first, subject, main_content)
  end
end
