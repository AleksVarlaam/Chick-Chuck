# frozen_string_literal: true

class TruckDecorator < ApplicationDecorator
  delegate_all

  def number
    "№ #{truck.company.title[0..1]}#{id}"
  end

  def body_type_name
    Truck.body_type_select.select { |body| return body[0] if body[1] == truck.body_type }
  end

  def assembly_name
    Truck.assembly_select.select { |item| return item[0] if item[1] == truck.assembly }
  end

  def formatted_assembly
    case truck.assembly
    when 1 then h.image_tag(h.asset_path('icons/icons8-done-40.png'), class: 'w-5 h-5', alt: "icons8-done-40")
    when 2 then (h.heroicon 'x-mark', class: 'w-5 h-5 text-red-700')
    else
      h.tag.p assembly_name, class: 'text-gray-600 italic'
    end
  end

  def formatted_packing
    case truck.packing
    when 1 then h.image_tag(h.asset_path('icons/icons8-done-40.png'), class: 'w-5 h-5', alt: "icons8-done-40")
    when 2 then (h.heroicon 'x-mark', class: 'w-5 h-5 text-red-700')
    end
  end
end
