# frozen_string_literal: true

module Admins
  class LanguagesController < ApplicationController
    layout 'profile_layout'
    before_action :authenticate_admin!
    before_action :set_language, only: %i[edit update destroy]

    def new
      @language = Language.new
    end

    def create
      @language = Language.new(language_params)
      respond_to do |format|
        if @language.save
          format.turbo_stream do
            flash.now[:success] =
              t('flash.success.created', model: @language.model_name.human + ' ' + @language.title)
          end
        else
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    end

    def edit; end

    def update
      respond_to do |format|
        if @language.update(language_params)
          format.turbo_stream do
            flash.now[:success] =
              t('flash.success.updated', model: @language.model_name.human + ' ' + @language.title)
          end
        else
          format.html { render :edit, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      respond_to do |format|
        if @language.destroy
          format.turbo_stream { flash.now[:success] = t('flash.success.destroyed', model: @language.model_name.human) }
        else
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    end

    private

    def language_params
      params.require(:language).permit(:title)
    end

    def set_language
      @language = Language.find_by_id(params[:id])
    end
  end
end
