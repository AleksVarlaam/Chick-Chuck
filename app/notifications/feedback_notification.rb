# frozen_string_literal: true

# To deliver this notification:
#
# CommentNotification.with(post: @post).deliver_later(current_user)
# CommentNotification.with(post: @post).deliver(current_user)

class FeedbackNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
  deliver_by :email, mailer: 'AdminMailer'
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  #
  param :feedback

  # Define helper methods to make rendering easier.
  #
  def message
    t('notification.feedback')
  end

  def object
    params[:feedback]
  end

  def url
    feedbacks_url(anchor: "feedback_#{params[:feedback].id}")
  end

  def avatar
    params[:feedback].user.avatar_thumb
  end

  def author
    params[:feedback].user.user_name
  end
end
