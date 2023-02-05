# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'phaybinc@phaybin.com'
  layout 'mailer'
end
