# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/company_mailer/example.html


class CompanyMailer < ApplicationMailer
  prepend_view_path "app/views/mailers"
  
  def review_notification
    @resource   = params[:review]
    @recipient  = @resource.reviewable
    I18n.locale = @recipient.locale
    
    mail to: @recipient.email,
         subject: I18n.t('review.reviews')
  end
end

