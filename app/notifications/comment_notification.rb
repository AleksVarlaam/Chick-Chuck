# frozen_string_literal: true

# To deliver this notification:
#
# CommentNotification.with(post: @post).deliver_later(current_user)
# CommentNotification.with(post: @post).deliver(current_user)

class CommentNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  #
  param :comment

  # Define helper methods to make rendering easier.
  #
  def message
    if comment.commentable.instance_of?(Comment)
      "#{t('notification.reply')} #{object_title}"
    else
      "#{t('notification.comment')} #{object_title}"
    end
  end

  def comment
    params[:comment]
  end

  def object_title
    case comment.object_type
    when Truck.name then "#{comment.object.model_name.human.downcase}: '#{comment.object.decorate.number}'"
    when News.name then "#{comment.object.model_name.human.downcase}: '#{comment.object.title}'"
    when User.name then "#{comment.object.model_name.human.downcase}: '#{comment.object.title}'"
    end
  end

  def url
    return user_path(id: comment.object_id, anchor: "comment_#{comment.id}") if comment.object_type == User.name
    [comment.object, { anchor: "comment_#{comment.id}" }]
  end

  def avatar
    comment.user.avatar_attachment_path
  end

  def author
    comment.user.user_name
  end
end
