# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'aleksvarlaam@gmail.com'
  layout 'mailer'
end
