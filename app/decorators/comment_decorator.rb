# frozen_string_literal: true

class CommentDecorator < ApplicationDecorator
  delegate_all

  def avatar
    h.image_tag(model.user.avatar_attachment_path,
                class: 'mt-2 object-cover rounded-full w-8 h-8 sm:w-10 sm:h-10', alt: 'user-avatar')
  end

  def author
    h.content_tag(:strong,
                  model.user.type == 'Company' ? model.user.title.capitalize : model.user.user_name)
  end

  def created_at
    h.content_tag(:span, (l comment.created_at, format: :short), class: 'text-xs ml-1 text-gray-400')
  end

  def updated_at
    return unless model.created_at != model.updated_at

    h.content_tag(:span, "#{h.t('comment.updated')}: #{l comment.updated_at, format: :short}",
                  class: 'text-xs text-gray-400')
  end

  def content
    h.simple_format(model.content, class: 'text-md')
  end
end
