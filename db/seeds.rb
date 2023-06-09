# frozen_string_literal: true

require 'ffaker'

# Clients
5.times do
  Client.create(email: FFaker::Internet.email, password: '1UhsX7Rp', password_confirmation: '1UhsX7Rp', phone: FFaker::PhoneNumberBR.phone_number,
                first_name: FFaker::Name.first_name, last_name: FFaker::Name.last_name, gender: 'Male', confirmed_at: Time.now)
end

# Companies
20.times do
  Company.create(email: FFaker::Internet.email, password: '1UhsX7Rp', password_confirmation: '1UhsX7Rp', phone: FFaker::PhoneNumberBR.phone_number, first_name: FFaker::Name.first_name, last_name: FFaker::Name.last_name, gender: 'Male', title: FFaker::InternetSE.company_name_single_word,
                 district_ids: District.all.ids.sample, language_ids: Language.all.ids.sample, facebook: 'facebook.com', website: 'example.com',
                 description: FFaker::Book.description, confirmed_at: Time.now)
end

# Products
price = (100..2000).to_a
product_images = ['1.jpg', '2.jpg', '3.jpg', '4.jpg', '5.jpg', '6.jpg', '7.jpg']

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
