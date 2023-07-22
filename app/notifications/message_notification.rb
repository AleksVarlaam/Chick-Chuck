# frozen_string_literal: true

# To deliver this notification:
#
# CommentNotification.with(post: @post).deliver_later(current_user)
# CommentNotification.with(post: @post).deliver(current_user)

class MessageNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
  deliver_by :email, mailer: 'UserMailer'
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  #
  param :message

  # Define helper methods to make rendering easier.
  #
  def message
    "#{object.content} by #{author}"
  end

  def object
    params[:message]
  end

  def url
    object.room
  end

  def avatar
    params[:message].user.avatar_thumb
  end

  def author
    params[:message].user.user_name
  end
end
