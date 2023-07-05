# frozen_string_literal: true

module Contents
  class MovingPreparationController < ApplicationController
    def index
      set_meta_tags(
        title: t('meta.moving_preparation.title'),
        description: t('meta.moving_preparation.desc'),
        alternate: {
          "x-default" => moving_preparation_url(locale: nil),
          "en" => moving_preparation_url(locale: :en),
          "ru" => moving_preparation_url(locale: :ru),
          "ua" => moving_preparation_url(locale: :ua),
        }
      )
    end
  end
end
