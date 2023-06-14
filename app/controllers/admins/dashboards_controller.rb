# frozen_string_literal: true

module Admins
  class DashboardsController < ApplicationController
    layout 'profile_layout'
    before_action :authenticate_admin!
    before_action :set_models

    def show
      @statistic = Statistic.first
      @companies_count = Company.confirmed.count
    end

    def users
      @users_count = @users.count
      @pagy_a, @users_pagy = pagy_array(@users, items: 10, fragment: '#users')
    end

    private

    def filter_params
      params.permit(:type, :user_name)
    end

    def set_models
      @users = User.user_filter(filter_params).newest
    end
  end
end
