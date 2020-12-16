# frozen_string_literal: true

FactoryBot.define do
  factory :invoice do
    customer_id { nil }
    merchant_id { nil }
    status { 'MyString' }
  end
end
