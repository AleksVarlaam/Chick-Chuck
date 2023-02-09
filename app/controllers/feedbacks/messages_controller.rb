# frozen_string_literal: true

module Feedbacks
  class MessagesController < ApplicationController
    layout 'profile_layout'
    before_action :authenticate_user!
    before_action :set_message, only: %i[edit update destroy]

    def create
      @new_message = current_user.messages.build(message_params)

      return unless @new_message.save

      @room = @new_message.room
      recipient = @new_message.recipient

      # Create room to recipient
      if @room.messages.count == 1
        @room.broadcast_append_to [recipient, :rooms], partial: 'feedbacks/rooms/room',
                                                       locals: { room: @room, current_user: recipient }
      end
      # Update room view to recipient in rooms
      @new_message.broadcast_update_to [recipient, @room], target: helpers.dom_id(@room),
                                                           partial: 'feedbacks/rooms/room', locals: { room: @room, current_user: recipient }
      # Append new message in room
      @new_message.broadcast_append_to @room, target: "room_#{@room.id}_messages",
                                              partial: 'feedbacks/messages/message'
    end

    def edit; end

    def update
      return unless current_user.messages.include?(@message)
      return unless @message.update(message_params)

      @message.broadcast_update_to @room, target: "room_#{@room.id}_message_#{@message.id}",
                                          partial: 'feedbacks/messages/message'
      respond_to do |format|
        format.turbo_stream { flash.now[:success] = t('flash.success.updated', model: @message.model_name.human) }
      end
    end

    def destroy
      return unless current_user.messages.include?(@message)
      return unless @message.destroy

      @message.broadcast_remove_to @message.room, target: "room_#{@room.id}_message_#{@message.id}"
      respond_to do |format|
        format.turbo_stream { flash.now[:success] = t('flash.success.destroyed', model: @message.model_name.human) }
      end
    end

    private

    def message_params
      params.require(:message).permit(:room_id, :content, images: [], append_images: [])
    end

    def set_message
      @message = Message.find(params[:id])
      @room = @message.room
    end
  end
end
