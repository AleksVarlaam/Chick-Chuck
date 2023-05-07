# frozen_string_literal: true

require 'ffaker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Client.create(email: FFaker::Internet.email, password: '1UhsX7Rp', password_confirmation: '1UhsX7Rp', phone: FFaker::PhoneNumberBR.phone_number,
              first_name: FFaker::Name.first_name, last_name: FFaker::Name.last_name, gender: 'Male', confirmed_at: Time.now)

10.upto(30) do |i|
  Company.create(email: FFaker::Internet.email, password: '1UhsX7Rp', password_confirmation: '1UhsX7Rp', phone: "+9725370139#{i}", first_name: FFaker::Name.first_name, last_name: FFaker::Name.last_name, gender: 'Male', title: FFaker::InternetSE.company_name_single_word,
                 district_ids: District.all.ids.sample, language_ids: Language.all.ids.sample, facebook: 'facebook.com', website: 'blablacar.com',
                 description: FFaker::Book.description, confirmed_at: Time.now)
end

length = (1..10).to_a
width = (1..3).to_a
height = (1..3).to_a
load_capacity = (3..15).to_a
price = (100..2000).to_a
truck_images = ['1.jpg', '2.jpg', '3.jpg', '4.jpg', '5.jpg', '6.jpg', '7.jpg', '8.jpg', '9.jpg', '10.jpg', '11.jpg',
                '12.jpg']
product_images = ['1.jpg', '2.jpg', '3.jpg', '4.jpg', '5.jpg', '6.jpg', '7.jpg']

40.times do
  truck = Truck.new(user_id: Company.all.ids.sample, district_ids: District.all.ids.sample, body_type: Truck.body_type_select.sample[1],
                    assembly: Truck.assembly_select.sample[1], packing: Truck.packing_select.sample[1], length: length.sample, width: width.sample, height: height.sample, load_capacity: load_capacity.sample)

  truck.images = [
    Pathname.new("app/assets/images/seed/trucks/#{truck_images.sample}").open,
    Pathname.new("app/assets/images/seed/trucks/#{truck_images.sample}").open
  ]

  truck.save
end

21.times do
  product = Product.new(user_id: Company.all.ids.sample, title: FFaker::Product.product_name,
                        condition: Product.condition_select.sample[1], delivery: Product.delivery_select.sample[1],
                        category_id: Category.all.ids.sample, thing_id: Thing.all.ids.sample, district_id: District.all.ids.sample,
                        city_id: City.all.ids.sample, description: FFaker::Book.description, price: price.sample)

  product.images = [
    Pathname.new("app/assets/images/seed/products/#{product_images.sample}").open,
    Pathname.new("app/assets/images/seed/products/#{product_images.sample}").open
  ]

  product.save
end
