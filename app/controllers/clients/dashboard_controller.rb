# frozen_string_literal: true

module Clients
  class DashboardController < ApplicationController
    layout 'profile_layout'
    before_action :authenticate_client!
    before_action :set_client, only: %i[index]

    def index; end

    private

    def set_client
      @client = current_client
    end
  end
end
