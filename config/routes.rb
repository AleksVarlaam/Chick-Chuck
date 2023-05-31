# frozen_string_literal: true

require 'sidekiq/web'

class AdminConstraint
  def matches?(request)
    request.env['warden'].user(:admin).present?
  end
end

Rails.application.routes.draw do
  # Error 404
  match '/404', to: 'errors#not_found', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all
  # Devise with omniauth_callbacks
  devise_for :clients, only: :omniauth_callbacks, controllers: { omniauth_callbacks: 'clients/omniauth_callbacks' }

  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    # Admins
    devise_for :admins, controllers: { registrations: 'admins/registrations' }, skip: [:registrations]
    as :admin do
      get 'admins/edit',  to: 'admins/registrations#edit',    as: 'edit_admin_registration'
      put 'admins',       to: 'admins/registrations#update',  as: 'admin_registration'
      namespace :admins, constraints: AdminConstraint.new do
        mount Sidekiq::Web => '/sidekiq' # Sidekiq
        resources :categories, except: %i[show], controller: 'catalog/categories' do
          resources :things, except: %i[show], controller: 'catalog/things'
        end
        resources :news, except: %i[show]
        resources :languages, except: %i[index show]
        resources :districts, except: %i[show]
        resource :dashboard, only: :show do
          get :users
        end
        post '/publish/news/:id', to: 'news#publish', as: 'publish_news'
      end
    end

    # Companies
    devise_for :companies, controllers: { registrations: 'companies/registrations' }
    namespace :companies do
      resources :prices, only: %i[index create update]
      resource  :calculator, only: %i[create update]
      get  '/dashboard',                to: 'dashboard#index',              as: 'dashboard'
      get  '/profile',                  to: 'profiles#profile',             as: 'edit_profile'
      put  '/profile',                  to: 'profiles#profile_update',      as: 'profile'
      get  '/company_info',             to: 'profiles#company_info',        as: 'edit_company_info'
      put  '/company_info',             to: 'profiles#company_info_update', as: 'company_info'
    end

    # Clients
    devise_for :clients, controllers: { registrations: 'clients/registrations' }, skip: :omniauth_callbacks
    namespace :clients do
      resource :profile, only: %i[edit update]
      get '/dashboard', to: 'dashboard#index', as: 'dashboard'
    end
    # Users
    namespace :users do
      resources :products, except: %i[show] do
        post '/publish',      to: 'products#publish',             as: 'publish'
        post '/mark_as_sold', to: 'products#mark_as_sold',        as: 'mark_as_sold'
      end
      # Email subscribers
      resources :mailers, only: [:create]
    end

    # Contents
    scope :contents do
      # Users
      resources :users, only: %i[index show], controller: 'users/users' do
        get '/modal',         to: 'users/users#modal',                  as: 'modal'
        get '/contacts',      to: 'users/users#contacts',               as: 'contacts'
      end

      # News content
      resources :news, only: %i[show index], controller: 'contents/news' do
        resources :comments, only: %i[new edit create update destroy], controller: 'feedbacks/comments'
      end

      # Company content
      resources :companies, only: %i[show], controller: 'contents/companies' do
        resources :comments, only: %i[new edit create update destroy], controller: 'feedbacks/comments'
      end

      # Comments
      resources :comments, only: %i[new edit create update destroy], controller: 'feedbacks/comments' do
        resources :comments, only: %i[new edit create update destroy], controller: 'feedbacks/comments'
      end

      # About page and comments
      get 'about', to: 'contents/statistics#show', as: 'about'
      resources :statistics, only: :show, controller: 'contents/statistics' do
        resources :comments, only: %i[new edit create update destroy], controller: 'feedbacks/comments'
      end

      # Products
      resources :products, only: %i[index show], controller: 'contents/products'
      get 'seller/:user_id/user_products', to: 'contents/products#user_products', as: 'user_products'

      # Calculator
      resource :calculator, only: %i[show], controller: 'contents/calculators' do
        get '/company/:company_id/calculator', to: 'contents/calculators#company_calculator', as: 'company'
      end

      # Moving preparation
      get '/moving_preparation', to: 'contents/main#moving_preparation'
    end
    
    # Reviews
    resources :reviews, only: %i[new create edit update], controller: 'feedbacks/reviews'
    
    # Carrierwave attachments
    namespace :carrierwave do
      resources :images, only: %i[show destroy]
    end

    # Rooms
    resources :rooms, only: %i[index show create], param: :title, controller: 'feedbacks/rooms' do
      resources :messages, only: %i[edit update create destroy], controller: 'feedbacks/messages'
    end

    # Notifications
    resources :notifications, only: [:index], controller: 'feedbacks/notifications'

    # Root path
    root to: 'contents/main#index'
  end
end
