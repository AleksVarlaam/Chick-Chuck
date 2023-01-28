# frozen_string_literal: true

module Admins
  class DashboardController < ApplicationController
    layout 'profile_layout'
    before_action :authenticate_admin!
    before_action :set_admin, only: %i[index]

    def index; end

    private

    def set_admin
      @admin = current_admin
    end
  end
end
