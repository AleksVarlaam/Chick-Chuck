# lib/patches/active_analytics.rb

ActiveAnalytics::ApplicationController.class_eval do
  before_action :require_admin

  def require_admin
    # This example supposes there are current_user and User#admin? methods
    raise ActionController::RoutingError.new("Not found") unless current_admin
  end
end