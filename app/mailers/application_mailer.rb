# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'info@chick-chuck.com'
  layout 'mailer'
end
