# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/company_mailer/example.html

class AdminMailer < ApplicationMailer
  prepend_view_path 'app/views/mailers'
  before_action :set_recipient

  def feedback_notification
    @resource = params[:feedback]

    mail to: @recipient.email,
         subject: I18n.t('review.reviews')
  end

  private

  def set_recipient
    @recipient  = Admin.first
    I18n.locale = @recipient.locale
  end
end
