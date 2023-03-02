# frozen_string_literal: true

# To deliver this notification:
#
# CommentNotification.with(post: @post).deliver_later(current_user)
# CommentNotification.with(post: @post).deliver(current_user)

class ReviewNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  #
  param :review

  # Define helper methods to make rendering easier.
  #
  def message
    "#{t('notification.review_truck')}: '#{object.decorate.number}'"
  end

  def object
    params[:review].reviewable
  end

  def url
    [object]
  end

  def avatar
    params[:review].user.avatar_attachment_path
  end

  def author
    params[:review].user.user_name
  end
end
