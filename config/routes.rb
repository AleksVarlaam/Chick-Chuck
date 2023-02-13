# frozen_string_literal: true

require 'sidekiq/web'

class AdminConstraint
  def matches?(request)
    request.env['warden'].user(:admin).present?
  end
end

Rails.application.routes.draw do
  devise_for :clients, only: :omniauth_callbacks, controllers: { omniauth_callbacks: 'clients/omniauth_callbacks' }

  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    # Sidekiq
    mount Sidekiq::Web => '/sidekiq', constraints: AdminConstraint.new

    # Admins
    devise_for :admins, controllers: { registrations: 'admins/registrations' }, skip: :omniauth_callbacks # , skip: [:registrations]
    as :admin do
      # get 'admins/edit',  to: 'admins/registrations#edit',    as: 'edit_admin_registration'
      # put 'admins',       to: 'admins/registrations#update',  as: 'admin_registration'
      namespace :admins, constraints: AdminConstraint.new do
        resources :categories, except: %i[show], controller: 'catalog/categories' do
          resources :things, except: %i[show], controller: 'catalog/things'
        end
        resources :news, except: %i[show]
        post '/publish/news/:id', to: 'news#publish', as: 'publish_news'
        resources :languages, except: %i[index show]
        resources :districts, except: %i[show]
        resource :dashboard, only: :show do
          get :users
        end
      end
    end

    # Companies
    devise_for :companies, controllers: { registrations: 'companies/registrations' }, skip: :omniauth_callbacks
    namespace :companies do
      resources :trucks, except: %i[show]
      post '/publish/truck/:id', to: 'trucks#publish', as: 'publish_truck'
      resources :products, except: %i[show]
      post '/publish/product/:id', to: 'products#publish', as: 'publish_product'
      resources :prices, only: %i[index create update]
      resource  :calculator, only: %i[create update]
      get '/dashboard',       to: 'dashboard#index',              as: 'dashboard'
      get '/profile',         to: 'profiles#profile',             as: 'edit_profile'
      put '/profile',         to: 'profiles#profile_update',      as: 'profile'
      get '/company_info',    to: 'profiles#company_info',        as: 'edit_company_info'
      put '/company_info',    to: 'profiles#company_info_update', as: 'company_info'
    end

    # Clients
    devise_for :clients, controllers: { registrations: 'clients/registrations' }, skip: :omniauth_callbacks
    namespace :clients do
      get '/dashboard',       to: 'dashboard#index', as: 'dashboard'
      resource :profile, only: %i[edit update]
    end

    # Contents
    namespace :contents, path: '' do
      resources :companies, only: %i[show]
      resource  :calculator, only: %i[show]
      resources :news, only: %i[index show]
      resources :trucks, only: %i[index show]
      resources :products, only: %i[index show]
      get '/company_modal/:id',           to: 'companies#modal',            as: 'company_modal'
      get '/company/:id/contacts',        to: 'companies#contacts',         as: 'contacts'
      get 'company/:id/calculator_modal', to: 'companies#calculator_modal', as: 'calculator_modal'
      get '/moving_preparation',          to: 'main#moving_preparation'
    end

    # Trucks feedbacks
    resources :trucks, only: %i[show index], controller: 'contents/trucks' do
      resources :reviews, only: %i[new create edit update], controller: 'feedbacks/reviews'
      resources :comments, only: %i[new edit create update destroy], controller: 'feedbacks/comments'
    end

    # News feedbacks
    resources :news, only: %i[show index], controller: 'contents/news' do
      resources :comments, only: %i[new edit create update destroy], controller: 'feedbacks/comments'
    end

    # Comments
    resources :comments, only: %i[new edit create update destroy], controller: 'feedbacks/comments' do
      resources :comments, only: %i[new edit create update destroy], controller: 'feedbacks/comments'
    end

    # Active storage attachments
    namespace :active_storage do
      resources :attachments, only: [:destroy]
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
