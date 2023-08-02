# frozen_string_literal: true

module Analytics
  extend ActiveSupport::Concern

  included do
    after_action :record_page_view

    def record_page_view
      # This condition should skip bots.
      return if request.is_crawler? || admin_signed_in?

      ActiveAnalytics.record_request(request)
    end
  end
end
