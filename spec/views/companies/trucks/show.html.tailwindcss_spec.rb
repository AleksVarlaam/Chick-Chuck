# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'companies/trucks/show', type: :view do
  before(:each) do
    @company_truck = assign(:company_truck, Companies::Truck.create!)
  end

  it 'renders attributes in <p>' do
    render
  end
end
