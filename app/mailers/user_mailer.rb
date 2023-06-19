# frozen_string_literal: true

class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def sending(user)
    @user = user
    mail to: user.email, 
         subject: 'Обновление'
  end
  
  def company
    Company.all.each { |company| UserMailer.sending(company).deliver_now }
  end
end
