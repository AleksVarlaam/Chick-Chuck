# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/company_mailer/example.html


class AdminMailer < ApplicationMailer
  prepend_view_path "app/views/mailers"
  
  def message_template(recipient, subject, title, title_content, main_content)
    @h1 = "Привет #{recipient.user_name} 👋🏻"
    @title = title
    @title_content = title_content
    @main_content  = main_content

    mail to: recipient.email,
         subject:
  end
  
  def feedback_notification
    feedback  = params[:feedback]
    subject   = Feedback.model_name.human
    recipient = Admin.first
    title     = "#{feedback.user.user_name} #{I18n.t('notification.feedback').downcase}:"
    title_content = feedback.title   || nil
    main_content  = feedback.content || nil
    
    AdminMailer.message_template(recipient, subject, title, title_content, main_content).deliver_now
  end


end

