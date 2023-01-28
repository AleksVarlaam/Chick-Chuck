# frozen_string_literal: true

module Admins
  class NewsController < ApplicationController
    layout 'profile_layout'
    before_action :authenticate_admin!
    before_action :set_new, only: %i[edit update publish destroy]

    def new
      @new = News.new
    end

    def create
      @new = current_admin.news.build(new_params)

      respond_to do |format|
        if @new.save
          format.turbo_stream do
            flash.now[:success] = t('flash.success.created', model: "#{@new.model_name.human} #{@new.title.downcase}")
          end
        else
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    end

    def index
      @pagy, @news = pagy(News.all.order(created_at: :desc), items: 8, fragment: '#news')
      @news = @news.decorate
    end

    def edit; end

    def update
      respond_to do |format|
        if @new.update(new_params)
          format.turbo_stream do
            flash.now[:success] = t('flash.success.updated', model: "#{@new.model_name.human} #{@new.title.downcase}")
          end
        else
          format.html { render :edit, status: :unprocessable_entity }
        end
      end
    end

    def publish
      return unless current_admin.news.include?(@new)

      respond_to do |format|
        if @new.published == false
          if @new.update(published: true)
            format.turbo_stream do
              flash.now[:success] =
                t('flash.success.published', model: "#{@new.model_name.human} #{@new.title.downcase}")
            end
          end
        elsif @new.update(published: false)
          format.turbo_stream do
            flash.now[:success] = t('flash.success.hided', model: "#{@new.model_name.human} #{@new.title.downcase}")
          end
        end
      end
    end

    def destroy
      respond_to do |format|
        if @new.destroy
          format.turbo_stream { flash.now[:success] = t('flash.success.destroyed', model: @new.model_name.human) }
        else
          format.html { render :index, status: :unprocessable_entity }
        end
      end
    end

    private

    def new_params
      params.require(:news).permit(:title, :description, :content, images: [], append_images: [])
    end

    def set_new
      @new = News.find_by_id(params[:id]).decorate
    end
  end
end
