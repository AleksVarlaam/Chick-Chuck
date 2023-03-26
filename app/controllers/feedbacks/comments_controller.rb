# frozen_string_literal: true

module Feedbacks
  class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_commentable, only: %i[new create]
    before_action :set_comment, only: %i[edit update destroy]

    def new
      @comment = Comment.new
    end

    def create
      @new_comment = current_user.comments.build(comment_params)
      @new_comment.commentable = @commentable
      # Set object of comment
      @new_comment.object = @new_comment.commentable.instance_of?(Comment) ? @commentable.object : @commentable

      return unless @new_comment.save

      if @new_comment.commentable.instance_of?(Comment)
        @new_comment.broadcast_append_to @new_comment.commentable,
                                         target: helpers.dom_id(@new_comment.commentable, :replies),
                                         partial: 'feedbacks/comments/comment', locals: { comment: @new_comment.decorate }
      else
        @new_comment.broadcast_prepend_to @commentable,
                                          target: helpers.dom_id(@commentable, :comments),
                                          partial: 'feedbacks/comments/comment', locals: { comment: @new_comment.decorate }
      end
    end

    def edit; end

    def update
      return unless current_user.comments.include?(@comment)
      return unless @comment.update(comment_params)

      @comment.broadcast_update_to @comment.commentable,
                                   target: helpers.dom_id(@comment),
                                   partial: 'feedbacks/comments/comment', locals: { comment: @comment.decorate }
      respond_to do |format|
        format.turbo_stream { flash.now[:success] = t('flash.success.updated', model: "#{@comment.model_name.human}") }
      end
    end

    def destroy
      return unless current_user.comments.include?(@comment) || current_admin
      return unless @comment.destroy

      @comment.broadcast_remove_to @comment.commentable,
                                   target: helpers.dom_id(@comment)

      respond_to do |format|
        format.turbo_stream { flash.now[:success] = t('flash.success.destroyed', model: "#{@comment.model_name.human}") }
      end
    end

    private

    def comment_params
      params.require(:comment).permit(:content, images: [], append_images: [])
    end

    def set_commentable
      @commentable = Company.find_by_id(params[:company_id]) if params[:company_id].present?
      @commentable = Truck.find_by_id(params[:truck_id])     if params[:truck_id].present?
      @commentable = News.find_by_id(params[:news_id])       if params[:news_id].present?
      @commentable = Comment.find_by_id(params[:comment_id]) if params[:comment_id].present?
      @commentable = Statistic.find_by_id(params[:statistic_id]) if params[:statistic_id].present?
    end

    def set_comment
      @comment = Comment.find_by_id(params[:id])
    end
  end
end
