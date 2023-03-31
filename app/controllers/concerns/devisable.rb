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

  # def after_sign_up_path_for(resource)
  #     root_path
  #   end
  #
  #   def after_inactive_sign_up_path_for(resource)
  #     root_path
  #   end
  #
  def after_sign_in_path_for(_resource)
    flash[:success] = "You are welcome, #{current_user.user_name}!"

    if request.referer.include?('/clients/sign_in') ||
       request.referer.include?('/clients/sign_up')        ||
       request.referer.include?('/clients/password')       ||
       request.referer.include?('/clients/confirmation')   ||
       request.referer.include?('/clients/sign_out')       ||
       request.referer.include?('/clients/auth')           ||
       request.referer.include?('/companies/sign_in')      ||
       request.referer.include?('/companies/sign_up')      ||
       request.referer.include?('/companies/password')     ||
       request.referer.include?('/companies/confirmation') ||
       request.referer.include?('/companies/sign_out')     ||
       request.referer.include?('/companies/auth')         ||
       request.referer.include?('/admins/sign_in')         ||
       request.referer.include?('/admins/sign_up')         ||
       request.referer.include?('/admins/password')        ||
       request.referer.include?('/admins/confirmation')    ||
       request.referer.include?('/admins/sign_out')        ||
       request.referer.include?('/admins/auth')

      root_path
    else
      request.referer
    end
  end
end
