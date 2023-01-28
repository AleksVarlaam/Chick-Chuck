# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'companies/trucks/edit', type: :view do
  before(:each) do
    @company_truck = assign(:companies_truck, Companies::Truck.create!)
  end

  it 'renders the edit companies_truck form' do
    render

    assert_select 'form[action=?][method=?]', companies_truck_path(@company_truck), 'post' do
    end
  end
end
