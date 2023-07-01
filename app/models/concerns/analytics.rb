# frozen_string_literal: true

module Analytics
  extend ActiveSupport::Concern

  included do
    after_action :record_page_view

    def record_page_view
      # This condition should skip bots.
      unless request.is_crawler?
        ActiveAnalytics.record_request(request)
      end
    end
  end
end
