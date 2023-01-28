# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Companies::TrucksController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/companies/trucks').to route_to('companies/trucks#index')
    end

    it 'routes to #new' do
      expect(get: '/companies/trucks/new').to route_to('companies/trucks#new')
    end

    it 'routes to #show' do
      expect(get: '/companies/trucks/1').to route_to('companies/trucks#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/companies/trucks/1/edit').to route_to('companies/trucks#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/companies/trucks').to route_to('companies/trucks#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/companies/trucks/1').to route_to('companies/trucks#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/companies/trucks/1').to route_to('companies/trucks#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/companies/trucks/1').to route_to('companies/trucks#destroy', id: '1')
    end
  end
end
