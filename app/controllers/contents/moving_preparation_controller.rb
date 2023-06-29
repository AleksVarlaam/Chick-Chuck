# frozen_string_literal: true

module Contents
  class MovingPreparationController < ApplicationController
    def index
      set_meta_tags(
        title: t('meta.moving_preparation.title'),
        description: t('meta.moving_preparation.desc')
      )
      Statistic.first.update(moving_preparation: Statistic.first.moving_preparation + 1) unless user_signed_in?
    end
  end
end
