# frozen_string_literal: true

module Clients
  class SessionsController < Devise::SessionsController
    before_action :configure_sign_in_params, only: [:create]

    # GET /resource/sign_in
    # def new
    #   super
    # end

    # POST /resource/sign_in
    # def create
    #   super
    # end

    # DELETE /resource/sign_out
    def destroy
      super do
        # Turbo requires redirects be :see_other (303); so override Devise default (302)
        return redirect_to after_sign_out_path_for(resource_name), status: :see_other
      end
    end

    protected

    # If you have extra params to permit, append them to the sanitizer.
    def configure_sign_in_params
      devise_parameter_sanitizer.permit(:sign_in, keys: %i[login password])
    end

    def after_sign_in_path_for(_resource)
      flash[:success] = "You are welcome, #{current_client.first_name}!" if client_signed_in?
      root_path
    end

    def after_sign_out_path_for(_resource_or_scope)
      flash[:info] = 'See you later!'
      root_path
    end
  end
end
