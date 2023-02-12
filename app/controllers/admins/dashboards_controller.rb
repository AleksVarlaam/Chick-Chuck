# frozen_string_literal: true

module Admins
  class DashboardsController < ApplicationController
    layout 'profile_layout'
    before_action :authenticate_admin!
    before_action :set_admin, only: %i[index]

    def show
      @users_count = User.where.not(type: 'Admin').count
    end
    
    def users
      @pagy_a, @users = pagy_array(User.user_filter(filter_params), items: 10, fragment: '#users')
    end

    private

    def filter_params
      params.permit(:type, :user_name)
    end

    def set_admin
      @admin = current_admin
    end
  end
end
