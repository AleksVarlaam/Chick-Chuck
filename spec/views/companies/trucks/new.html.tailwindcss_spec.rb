# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'companies/trucks/new', type: :view do
  before(:each) do
    assign(:company_truck, Company::Truck.new)
  end

  it 'renders new companies_truck form' do
    render

    assert_select 'form[action=?][method=?]', companies_trucks_path, 'post' do
    end
  end
end
