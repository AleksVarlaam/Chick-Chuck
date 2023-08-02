# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/company_mailer/example.html

class UserMailer < ApplicationMailer
  prepend_view_path 'app/views/mailers'

  def message_notification
    @resource   = params[:message]
    @recipient  = @resource.recipient
    I18n.locale = @recipient.locale

    mail to: @recipient.email,
         subject: Message.model_name.human
  end
end
