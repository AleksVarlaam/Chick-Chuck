# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/user
class UserMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/user/welcome
  def sending
    UserMailer.sending(Company.first)
  end
end
