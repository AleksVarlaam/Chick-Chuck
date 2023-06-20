# frozen_string_literal: true

module Users
  class UsersController < ApplicationController
    include Feedbacks::ReviewsHelper
    include PricesHelper
    before_action :set_user, only: %i[show modal contacts]
    before_action :set_index_title, only: :index
    after_action :update_views, only: :show

    def index
      Statistic.first.update(companies: Statistic.first.companies + 1) unless user_signed_in?
      companies = Company.confirmed.user_filter(filter_params)
      @best_companies = companies.take(3)
      latest_companies = companies.drop(3)
      @companies_count = latest_companies.count
      @pagy_a, @latest_companies = pagy_array(latest_companies, items: 8)
    end

    def show
      set_meta_tags( 
        title: [t('israel'), @user.user_name.capitalize],
        description: (@user.class.name == Company.name && @user.description.present?) ? @user.description.to_s : "#{@user.user_name.capitalize} | #{t('company.carriers').capitalize} | #{t('israel')}"
      )
      
      return redirect_to root_path unless @user.instance_of?(Company)

      @commentable = @user
      @comment = Comment.new
      @reviewable = @user
      @review = current_client&.company_review(@reviewable) || Review.new
      @reviews = @user.reviews.where.not(content: nil || '', title: nil || '')
      @reviews_count = @reviews.count
      @pagy, @reviews = pagy(@reviews, items: 10, fragment: '#reviews')
    end

    def modal
      set_meta_tags( 
        title: [t('user_menu.profile'), @user.user_name.capitalize],
        description: ("#{@user.user_name.capitalize} | #{t('user_menu.profile')}"),
        noindex: true
      )
    end

    def contacts
      set_meta_tags( 
        title: [t('contacts'), @user.user_name.capitalize],
        description: ("#{@user.user_name.capitalize} | #{t('contacts')}"),
        noindex: true
      )
      # return redirect_to new_client_session_path, alert: t('devise.failure.unauthenticated') unless user_signed_in?
    end

    private
    
    def set_index_title
      title_district = District.find(params[:district_id]).decorate.title if params[:district_id].present?
      title_language = Language.model_name.human.downcase + '-' + Language.find(params[:language_id]).title if params[:language_id].present?
      title_services = Service.where(id: params[:service_ids]).decorate.map(&:title).join(', ').downcase if params[:service_ids].present?
      
      @title_h1 = [ 
        title_district, title_services, title_language 
      ].join(', ').sub(/^(, )+/, '').sub(/(, )+$/, '').sub(/( , )+/, ' ')
      
      title_meta =  if title_services.present?
                      [t('israel'), title_services.capitalize]
                    elsif title_district.present?
                      [t('israel'), title_district, t('meta.carriers.title')]
                    elsif title_language.present?
                      [t('israel'), title_language, t('meta.carriers.title')]
                    else
                      [t('israel'), t('meta.carriers.title')]
                    end
      
      set_meta_tags( 
        title: title_meta,
        description: t('meta.carriers.desc'),
        keywords: @title_h1
      )
    end

    def filter_params
      params.permit(:district_id, :language_id, service_ids: [])
    end

    def set_user
      @user = User.find(params[:user_id] || params[:id])
    end

    def update_views
      return if current_admin || current_company == @user

      @user.update(views: @user.views + 1)
    end
  end
end
