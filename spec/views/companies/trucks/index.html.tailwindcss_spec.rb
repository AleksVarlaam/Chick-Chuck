# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'companies/trucks/index', type: :view do
  before(:each) do
    assign(:company_trucks, [
             Companies::Truck.create!,
             Companies::Truck.create!
           ])
  end

  it 'renders a list of companies/trucks' do
    render
  end
end
