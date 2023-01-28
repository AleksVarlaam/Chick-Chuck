# frozen_string_literal: true

module Devisable
  extend ActiveSupport::Concern

  included do
    devise_group :user, contains: %i[admin client company]
    before_action :configure_sign_up_params, only: [:create], if: :devise_controller?
  end

  protected

  def sign_up_params
    devise_parameter_sanitizer.sanitize(:sign_up) { |client| client.permit(permitted_attributes) }
    devise_parameter_sanitizer.sanitize(:sign_up) { |company| company.permit(permitted_attributes) }
  end

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: permitted_attributes)
    devise_parameter_sanitizer.permit :sign_in, keys: %i[login password]
  end

  def permitted_attributes
    [:email, :phone, :password, :password_confirmation,
     :first_name, :last_name, :avatar, :gender, :birthday, :city,
     :additional_phone, :whatsapp, :telegram, :facebook, :title, :website, :description, { district_ids: [], language_ids: [] }]
  end

  # def after_sign_in_path_for(resource)
  #     stored_location_for(resource) || request.referer || root_path
  #   end
end
