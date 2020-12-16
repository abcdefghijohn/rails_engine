# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    name { Fake::Commerce.product_name }
    description { Faker::Marketing.buzzwords }
    unit_price { Faker::Commerce.price }
  end
end
