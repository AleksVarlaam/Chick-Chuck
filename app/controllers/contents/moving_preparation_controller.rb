# frozen_string_literal: true

module Contents
  class MovingPreparationController < ApplicationController
    def index
      set_meta_tags(
        title: t('meta.moving_preparation.title'),
        description: t('meta.moving_preparation.desc')
      )
    end
  end
end
