# frozen_string_literal: true

module Companies
  class DashboardController < ApplicationController
    layout 'profile_layout'
    before_action :authenticate_company!
    before_action :set_company, only: %i[index]

    def index; end

    private

    def set_company
      @company = current_company
    end
  end
end
