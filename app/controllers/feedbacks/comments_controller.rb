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

      if @new_comment.save
        if @new_comment.commentable.instance_of?(Comment)
          @new_comment.broadcast_append_to @new_comment.commentable,
                                           target: helpers.dom_id(@new_comment.commentable, :replies),
                                           partial: 'feedbacks/comments/comment', locals: { comment: @new_comment.decorate }
        else
          @new_comment.broadcast_prepend_to @commentable,
                                            target: helpers.dom_id(@commentable, :comments),
                                            partial: 'feedbacks/comments/comment', locals: { comment: @new_comment.decorate }
        end
      else
        respond_to do |format|
          format.turbo_stream { flash.now[:alert] = t('flash.alert') }
        end
      end
    end

    def edit; end

    def update
      respond_to do |format|
        if current_user.comments.include?(@comment) && @comment.update(comment_params)

          @comment.broadcast_update_to @comment.commentable,
                                       target: helpers.dom_id(@comment),
                                       partial: 'feedbacks/comments/comment', locals: { comment: @comment.decorate }

          format.turbo_stream do
            flash.now[:success] = t('flash.success.updated', model: @comment.model_name.human.to_s)
          end
        else
          format.turbo_stream { flash.now[:alert] = t('flash.alert') }
        end
      end
    end

    def destroy
      respond_to do |format|
        if (current_user.comments.include?(@comment) || current_admin) && @comment.destroy

          @comment.broadcast_remove_to @comment.commentable,
                                       target: helpers.dom_id(@comment)

          format.turbo_stream do
            flash.now[:success] = t('flash.success.destroyed', model: @comment.model_name.human.to_s)
          end
        else
          format.turbo_stream { flash.now[:alert] = t('flash.alert') }
        end
      end
    end

    private

    def comment_params
      params.require(:comment).permit(:content, images: [], append_images: [])
    end

    def set_commentable
      if params[:company_id].present?
        @commentable = Company.find_by_id(params[:company_id])
      elsif params[:truck_id].present?
        @commentable = Truck.find_by_id(params[:truck_id])
      elsif params[:news_id].present?
        @commentable = News.find_by_id(params[:news_id])
      elsif params[:comment_id].present?
        @commentable = Comment.find_by_id(params[:comment_id])
      elsif params[:statistic_id].present?
        @commentable = Statistic.first
      end
    end

    def set_comment
      @comment = Comment.find_by_id(params[:id])
    end
  end
end
