# frozen_string_literal: true

module PricesHelper
  def price(thing)
    price = thing.prices.find_by(user_id: current_company.id)
  end

  def total_price(company)
    thing_prices = []
    params.each do |key, value|
      company.prices.each { |price| thing_prices << price.amount * value.to_i if price.thing_id == key.to_i }
    end

    thing_prices = thing_prices.sum
    distance = company.calculator.distance * params[:distance].to_i || 1

    floor_down = if params[:floor_down].to_i.positive?
                   thing_prices / 100 * (company.calculator.floor_down * params[:floor_down].to_i || 1)
                 elsif params[:floor_down_elevator].to_i.positive?
                   thing_prices / 100 * (company.calculator.floor_down_elevator * params[:floor_down_elevator].to_i || 1)
                 else
                   0
                 end

    floor_up = if params[:floor_up].to_i.positive?
                 thing_prices / 100 * (company.calculator.floor_up * params[:floor_up].to_i || 1)
               elsif params[:floor_up_elevator].to_i.positive?
                 thing_prices / 100 * (company.calculator.floor_up_elevator * params[:floor_up_elevator].to_i || 1)
               else
                 0
               end

    (thing_prices + distance + floor_down + floor_up).to_f.round(1)
  end
end
