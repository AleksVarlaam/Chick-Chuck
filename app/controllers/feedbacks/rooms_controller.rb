# frozen_string_literal: true

module Feedbacks
  class RoomsController < ApplicationController
    layout 'profile_layout'
    before_action :authenticate_user!
    before_action :set_rooms, only: %i[index show]
    before_action :check_room_dublicate, :recipient, only: :create

    def index; end

    def show
      @room = Room.find_by!(title: params[:title])

      # Redirect to room if user include this room
      return redirect_to root_path unless current_user.rooms.include?(@room)

      @messages = @room.messages.latest
      @new_message = current_user.messages.build(room: @room)

      # Update unread notifications of messages of room
      @messages.map do |message|
        unless message.user == current_user
          message.update(readed: true)
          message.notifications_as_message.update(read_at: Time.zone.now)
        end
      end
    end

    def create
      @new_room = Room.new(users: [current_user, recipient])

      if @new_room.save
        redirect_to room_path(@new_room.title)
      else
        redirect_to rooms_path, alert: t('flash.alert')
      end
    end

    private

    def room_params
      params.require(:room).permit(:recipient_id)
    end

    def recipient
      User.find(room_params[:recipient_id])
    end

    def set_rooms
      @current_user = current_user
      @rooms =  search_chat || current_user.rooms.includes(:messages).order('messages.created_at DESC')
    end

    def search_chat
      return unless params[:chatname].present?

      rooms = []
      current_user.rooms.each do |room|
        room.users.select { |user| rooms << room if user.user_name.downcase == params[:chatname].downcase }
      end
      rooms
    end

    def check_room_dublicate
      return redirect_to rooms_path if current_user == recipient

      @room = current_user.rooms.joins(:users).find_by('users.id' => room_params[:recipient_id])

      return unless @room.present?

      @messages = @room.messages.latest
      @new_message = current_user.messages.build(room: @room)
      redirect_to room_path(@room.title)
    end
  end
end
